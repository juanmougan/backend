class Student < ActiveRecord::Base
  belongs_to :career
  has_many :notifications, through: :subscription_lists
  
  has_many :enrollments, inverse_of: :student
  has_many :subjects, through: :enrollments

end
