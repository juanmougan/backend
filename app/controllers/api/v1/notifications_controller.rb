class Api::V1::NotificationsController < ApplicationController

  respond_to :json

  # GET /notifications/1
  # GET /notifications/1.json
  def show
  end

  # API only version
  def create
    notification_params = Hash.new
    notification_params[:title] = params[:title]
    notification_params[:message] = params[:message]
    notification_params[:subscription_list] = SubscriptionList.find(params[:subscription_list])
    @notification = Notification.new(notification_params)

    if @notification.save
      puts "\n\n\n\n\n\n\nWill respond with #{@notification}\n\n\n\n\n\n\n\n"
      respond_with @notification
    else
      puts "\n\n\n\n\n\n\nWill respond with #{@notification.errors}\n\n\n\n\n\n\n\n"
      respond_with @notification.errors
    end
  end

end
