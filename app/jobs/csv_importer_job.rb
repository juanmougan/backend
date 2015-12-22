require_relative 'parseCsv/csv_parser'
require_relative 'parseCsv/student_hash_creator'

class CsvImporterJob < ActiveJob::Base
  queue_as :default

  def perform(*args)

  	if args.length < 1
		raise RuntimeError, "Missing CSV input file"
	end

	puts "\n\n\n\n\n\nStarting CSV parse..."
	start_time = Time.now

	# Parse the CSV
	csv_parser = CsvParser.new(args[0])
	raw_student_rows = csv_parser.parse_file

	# Create the Hash containing all the Students, with their database id as key
	student_hash_creator = StudentHashCreator.new(raw_student_rows)
	student_hash = student_hash_creator.create_student_hash

	end_time = Time.now
	puts "\n\n\nParse took: #{end_time - start_time} seconds\n\n\n"

	destroy_previous_data
	store_all_students(student_hash)
  end

  def destroy_previous_data
  	Enrollment.destroy_all
	raise RuntimeError, "Failed to destroy all Enrollments" unless Enrollment.all.size == 0
	Student.destroy_all
	raise RuntimeError, "Failed to destroy all Students" unless Student.all.size == 0
  end

  def store_all_students(student_hash)
  	# Store the Hash in the DB
	ActiveRecord::Base.transaction do
		student_hash.keys.each do |k|
			some_student = student_hash[k]
			student = Student.new
			student.csv_id = some_student.id
			student.first_name = some_student.first_name.strip!
			student.last_name = some_student.last_name
			student.file_number = some_student.file_number
			student.career = Career.find_by code: some_student.career_code
			student.save!
			store_enrollments_for_student(student, some_student.raw_enrollments) 	# TODO error handling here. Raise an exception?
		end
	end
  end

  def store_enrollments_for_student(student, raw_enrollments)
  	raw_enrollments.each do |raw_enrollment|
  		Enrollment.create(:year => Date.current.year, :student => student, :subject => raw_enrollment.subject, 
  			:professorship => raw_enrollment.professorship, :shift => raw_enrollment.shift)
  	end
  end
end
