class AddProfessorshipAndShiftToEnrollment < ActiveRecord::Migration
  def change
    add_column :enrollments, :professorship, :string
    add_column :enrollments, :shift, :string
  end
end
