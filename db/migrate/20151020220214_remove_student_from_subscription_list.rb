class RemoveStudentFromSubscriptionList < ActiveRecord::Migration
  def change
    remove_column :subscription_lists, :student_id, :integer
  end
end
