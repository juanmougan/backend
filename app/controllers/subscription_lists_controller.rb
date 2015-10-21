class SubscriptionListsController < ApplicationController
  before_action :set_subscription_list, only: [:show, :edit, :update, :destroy]

  # GET /subscription_lists
  # GET /subscription_lists.json
  def index
    @subscription_lists = SubscriptionList.all
  end

  # GET /subscription_lists/1
  # GET /subscription_lists/1.json
  def show
  end

  # GET /subscription_lists/new
  def new
    @subscription_list = SubscriptionList.new
  end

  # GET /subscription_lists/1/edit
  def edit
  end

  # POST /subscription_lists
  # POST /subscription_lists.json
  def create
    @subscription_list = SubscriptionList.new(subscription_list_params)

    respond_to do |format|
      if @subscription_list.save
        format.html { redirect_to @subscription_list, notice: 'Subscription list was successfully created.' }
        format.json { render :show, status: :created, location: @subscription_list }
      else
        format.html { render :new }
        format.json { render json: @subscription_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscription_lists/1
  # PATCH/PUT /subscription_lists/1.json
  def update
    respond_to do |format|
      if @subscription_list.update(subscription_list_params)
        format.html { redirect_to @subscription_list, notice: 'Subscription list was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription_list }
      else
        format.html { render :edit }
        format.json { render json: @subscription_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscription_lists/1
  # DELETE /subscription_lists/1.json
  def destroy
    @subscription_list.destroy
    respond_to do |format|
      format.html { redirect_to subscription_lists_url, notice: 'Subscription list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription_list
      @subscription_list = SubscriptionList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_list_params
      params[:subscription_list].permit(:name, :description)
    end
end
