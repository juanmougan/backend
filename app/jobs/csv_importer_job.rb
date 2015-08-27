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

	# Parse the CSV
	csv_parser = CsvParser.new(args[0])
	raw_student_rows = csv_parser.parse_file

	# Create the Hash containing all the Students, with their database id as key
	student_hash_creator = StudentHashCreator.new(raw_student_rows)
	student_hash = student_hash_creator.create_student_hash

	pp student_hash

	# TODO store the Hash in the DB

  end
end
