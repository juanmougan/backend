class Api::V1::NotificationsController < ApplicationController

  respond_to :json

  # GET /notifications/1
  # GET /notifications/1.json
  def show
  end

  # API only version
  def create
    puts "\n\n\n\n\nHere are the params: #{params}\n\n\n\n\n"
    puts "\n\n\n\n\nTitle: #{params[:title]}\n\n\n\n\n"
    puts "\n\n\n\n\nMessage: #{params[:message]}\n\n\n\n\n"
    puts "\n\n\n\n\nSL: #{params[:subscription_list]}\n\n\n\n\n"
    notification_params = Hash.new
    notification_params[:title] = params[:title]
    notification_params[:message] = params[:message]
    notification_params[:subscription_list] = SubscriptionList.find(params[:subscription_list])
    @notification = Notification.new(notification_params)
    #@notification.subscription_list = SubscriptionList.find(params[:subscription_list])

    if @notification.save
      puts "\n\n\n\n\n\n\nWill respond with #{@notification}\n\n\n\n\n\n\n\n"
      respond_with @notification
    else
      puts "\n\n\n\n\n\n\nWill respond with #{@notification.errors}\n\n\n\n\n\n\n\n"
      respond_with @notification.errors
    end

=begin
    respond_to do |format|
      if @notification.save
        #format.json { render :show, status: :created, location: @notification }
        #render json: @notification
      else
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
=end
  end

end
