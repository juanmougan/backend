class Student < ActiveRecord::Base
  belongs_to :career
  #has_many :subscription_lists
  has_and_belongs_to_many :subscription_lists
  has_many :enrollments
  #has_many :notifications, through: :subscription_lists
  
  has_many :enrollments, inverse_of: :student
  has_many :subjects, through: :enrollments

  # Returns all the Students by their Career id.
  def self.get_students_by_career_id(career_id)
  	return Student.where(:career_id => career_id)
  end

  # Returns all the Students that are enrolled to a specific Subject.
  def self.get_students_by_list_of_subject_id(career_id)
  	enrollments = Enrollment.where(:subject_id => career_id)
    student_ids = enrollments.map { |e| e.student_id }
    return Student.where :id => student_ids
  end

end
