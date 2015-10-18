class CreateSubscriptionLists < ActiveRecord::Migration
  def change
    create_table :subscription_lists do |t|
      t.string :name
      t.references :student, index: true, foreign_key: true
      t.references :notification, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
