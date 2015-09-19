class Student < ActiveRecord::Base
  belongs_to :career
  has_many :notifications, through: :subscription_lists
  has_many :subjects, through: :enrollments
end
