class Subject < ActiveRecord::Base
  belongs_to :career
  has_many :students, through: :enrollments
  has_many :professors, through: :assignments
end
