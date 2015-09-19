class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :message
      t.datetime :sent_at

      t.timestamps null: false
    end
  end
end
