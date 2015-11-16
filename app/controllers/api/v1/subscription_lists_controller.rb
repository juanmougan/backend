class Api::V1::SubscriptionListsController < ApplicationController

  # API only version
  def index
    @subscription_lists = SubscriptionList.all
  end

end
