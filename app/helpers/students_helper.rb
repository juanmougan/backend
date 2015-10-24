module StudentsHelper
	def get_career_data_nil_safe(career)
		"#{career.code} - #{career.name}" unless career.nil?
	end
end
