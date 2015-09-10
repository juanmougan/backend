require 'pp'

# TODO create ActiveRecord models and use them. Rails probably provides a context
require_relative 'parseCsv/model/career'
require_relative 'parseCsv/model/student'
require_relative 'parseCsv/model/student_row'
require_relative 'parseCsv/model/subject'

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
	puts "\n\n\n\n\n\Parse took: #{end_time - start_time} seconds"
	pp student_hash

	# Store the Hash in the DB
	# TODO refactor - extract to another method
	student_hash.keys.each do |k|
		someStudent = student_hash[k]
		flat_student = FlatStudent.new
		flat_student.csv_id = someStudent.id
		flat_student.first_name = someStudent.first_name
		flat_student.last_name = someStudent.last_name
		flat_student.file_number = someStudent.file_number
		flat_student.career = someStudent.career
		puts "\n\nObject to be inserted..."
		pp flat_student
		puts flat_student.save!	# TODO error handling here. Raise an exception?
	end

  end
end
