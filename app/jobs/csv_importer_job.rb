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

	# Store the Hash in the DB
	# TODO refactor - extract to another method
	ActiveRecord::Base.transaction do
			student_hash.keys.each do |k|
			some_student = student_hash[k]
			student = Student.new
			student.csv_id = some_student.id
			student.first_name = some_student.first_name
			student.last_name = some_student.last_name
			student.file_number = some_student.file_number
			# Query example: 		Subject.where(name: 'Ingeniería de Software II', id: 1)
			# Ejemplo para Informática: 	Career.where(code: 11)
			# flat_student.career = some_student.career				# TODO add Career, see: https://github.com/juanmougan/backend/issues/1
			# student.career = Career.where(code: some_student.career_code)
			student.career = Career.find_by code: some_student.career_code
			# student.career = Career.where(code: some_student.career_code).first
			puts student.save!	# TODO error handling here. Raise an exception?
		end
	end

  end
end
