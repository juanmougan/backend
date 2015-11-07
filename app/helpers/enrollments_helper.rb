module EnrollmentsHelper
  def get_student_full_name(student)
  	"for #{student.last_name}, #{student.first_name}" unless student.nil?
  end
end
