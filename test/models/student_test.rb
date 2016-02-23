require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  test "get_students_by_career_id" do
  	students = Student.get_students_by_career_id(4)
    assert_equal 1, students.size
    assert_equal "00000001", students.first.file_number
  end
end
