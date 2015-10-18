class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :csv_id
      t.string :first_name
      t.string :last_name
      t.string :file_number
      t.references :career, index: true, foreign_key: true
      t.string :regid
      t.string :email

      t.timestamps null: false
    end
  end
end
