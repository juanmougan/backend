module EnrollmentsHelper
  def get_student_full_name_from_enrollments(enrollments)
  	"for #{enrollments.first.student.last_name}, #{enrollments.first.student.first_name}" unless enrollments.first.nil?
  end
end
