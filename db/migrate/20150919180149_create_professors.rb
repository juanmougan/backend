class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :first_name
      t.string :last_name
      t.string :file_number
      t.string :regid
      t.string :email

      t.timestamps null: false
    end
  end
end
