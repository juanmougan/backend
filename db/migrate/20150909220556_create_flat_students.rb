class CreateFlatStudents < ActiveRecord::Migration
  def change
    create_table :flat_students do |t|
      t.integer :csv_id
      t.string :first_name
      t.string :last_name
      t.string :file_number
      t.string :career

      t.timestamps null: false
    end
  end
end
