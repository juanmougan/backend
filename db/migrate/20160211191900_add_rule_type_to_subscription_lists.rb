class AddRuleTypeToSubscriptionLists < ActiveRecord::Migration
  def change
    add_column :subscription_lists, :rule_type, :integer, default: 0, null: false
  end
end
