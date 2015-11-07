class AddDescriptionToSubscriptionLists < ActiveRecord::Migration
  def change
    add_column :subscription_lists, :description, :string
  end
end
