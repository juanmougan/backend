class AddSubscriptionListToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :subscription_list, index: true, foreign_key: true
  end
end
