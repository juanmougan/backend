class CreateStudentsAndSubscriptionLists < ActiveRecord::Migration
  def change
    create_table :students_subscription_lists, id: false do |t|
      t.belongs_to :student, index: true
      t.belongs_to :subscription_list, index: true
    end
  end
end
