class Api::V1::SubscriptionListsController < ApplicationController

  respond_to :json

  # API only version
  def index
    respond_with SubscriptionList.all
  end

end
