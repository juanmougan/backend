require_relative 'parseCsv/csv_parser'
require_relative 'parseCsv/student_hash_creator'

class CsvImporterJob < ActiveJob::Base
  queue_as :default

  def perform(*args)

    if args.length < 1
      raise RuntimeError, "Missing CSV input file"
    end

    @career_lists_hash = Hash.new
    @subject_lists_hash = Hash.new
    @students_regids = Hash.new

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

    # First, save Student data
    save_in_memory_students_regids
    save_in_memory_previous_students
    puts "\n\n\n\n\nRegids: #{@students_regids}\n\n\n\n\n"
    # Then, re-create all Students TODO re-add regids!
    destroy_previous_data
    store_all_students(student_hash)
    add_students_again_to_subscription_lists
  end

  def save_in_memory_students_regids
    all_students = Student.all
    all_students.each{ |s| @students_regids[s.file_number] = s.regid }
  end

  def add_students_again_to_subscription_lists
    # Iterate over all keys for both hashes, and re-add the Students to the SL
    add_students_to_career_list
    add_students_to_subject_list
  end

  def add_students_to_career_list
    @career_lists_hash.keys.each do |k|
      # First, fetch the proper SL
      sl = SubscriptionList.find(k)
      # Second, get all Students by their file number
      students_for_list = []
      @career_lists_hash[k].each { |student_file_number|
        #students_for_list << Student.where(file_number: student_file_number).to_a
        sl.students << Student.where(file_number: student_file_number).to_a
      }
      # Then, add its Students again
      #sl.students = students_for_list
      sl.save!
    end
  end

  def add_students_to_subject_list
    @subject_lists_hash.keys.each do |k|
      # First, fetch the proper SL
      sl = SubscriptionList.find(k)
      # Second, get all Students by their file number
      students_for_list = []
      @subject_lists_hash[k].each { |student_file_number|
        sl.students << Student.where(file_number: student_file_number)
      }
      # Then, add its Students again
      #sl.students = students_for_list
      sl.save!
    end
  end

  # Keeps in memory all the SubscriptionLists' Students as a hash, where each
  #  SubscriptionList's id are the keys, and all the Students for that SL are
  #  the values.
  # For example:
  # {sl_id_1=>"FirstStudentFileNumber, SecondStudentFileNumber, ThirdStudentFileNumber", 
  #  sl_id_2=>" ... "}
  def save_in_memory_previous_students
    get_students_file_numbers_for_careers_list
    get_students_file_numbers_for_subjects_list
  end

  # TODO choose a better name
  def get_students_file_numbers_for_careers_list
    # Find all SL that are type Career
    career_subscription_lists = SubscriptionList.retrieve_career_subscription_lists
    # For each list, add this to the Hash. The SL id is the key. The List of Students' file numbers is the value
    career_subscription_lists.each do |sl|
      file_numbers = sl.get_all_students_file_numbers
      @career_lists_hash[sl.id] = file_numbers
    end
  end

  # TODO choose a better name
  def get_students_file_numbers_for_subjects_list
    # Find all SL that are type Subject
    subjects_subscription_lists = SubscriptionList.retrieve_subject_subscription_lists
    # For each list, add this to the Hash. The SL id is the key. The List of Students' file numbers is the value
    subjects_subscription_lists.each do |sl|
      file_numbers = sl.get_all_students_file_numbers
      @subject_lists_hash[sl.id] = file_numbers
    end
  end

  def destroy_previous_data
    ActiveRecord::Base.transaction do
      Enrollment.destroy_all
    end
    raise RuntimeError, "Failed to destroy all Enrollments" unless Enrollment.all.size == 0
    remove_students_for_each_subscription_list
    ActiveRecord::Base.transaction do
      Student.destroy_all
    end
    raise RuntimeError, "Failed to destroy all Students" unless Student.all.size == 0
  end

  def remove_students_for_each_subscription_list
    all_subscription_lists = SubscriptionList.all
    all_subscription_lists.each do |sl| 
      sl.students = []
      raise RuntimeError, "Failed to remove all Students for SubscriptionList: #{sl}" unless sl.students.size == 0
    end
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
        student.regid = @students_regids[student.file_number]     # Restore the Student regid
        student.career = Career.find_by code: some_student.career_code
        student.save!
        store_enrollments_for_student(student, some_student.raw_enrollments)   # TODO error handling here. Raise an exception?
        #update_existing_career_subscription_list(student)
        #update_existing_subjects_subscription_lists(student, some_student.raw_enrollments)
      end
    end
  end

  # Will asume at most only one SubscriptionList for each Career
  def update_existing_career_subscription_list(student)
    subscription_list = SubscriptionList.find_by_career_code(student.career.code)
    puts "\n\n\n\n\n\n#{subscription_list} is type #{subscription_list.class} and has #{subscription_list.size} elements\n\n\n\n\n\n"
    subscription_list.students << student
    subscription_list.save!
  end

  def update_existing_subjects_subscription_lists(student, raw_enrollments)
    raw_enrollments.each do |raw_enrollment|
      subscription_list = SubscriptionList.find_by_subject_code(raw_enrollment.subject.code)
      subscription_list.students << student
      subscription_list.save!
    end
  end

  def store_enrollments_for_student(student, raw_enrollments)
    raw_enrollments.each do |raw_enrollment|
      Enrollment.create(:year => Date.current.year, :student => student, :subject => raw_enrollment.subject, 
        :professorship => raw_enrollment.professorship, :shift => raw_enrollment.shift)
    end
  end
end
