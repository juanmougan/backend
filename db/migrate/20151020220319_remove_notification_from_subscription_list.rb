class RemoveNotificationFromSubscriptionList < ActiveRecord::Migration
  def change
    remove_column :subscription_lists, :notification_id, :integer
  end
end
