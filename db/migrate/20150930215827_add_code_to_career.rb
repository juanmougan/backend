class AddCodeToCareer < ActiveRecord::Migration
  def change
    add_column :careers, :code, :integer
  end
end
