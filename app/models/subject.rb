class Subject < ActiveRecord::Base
  belongs_to :career
  has_many :professors, through: :assignments

  has_many :enrollments, inverse_of: :subject
  has_many :students, through: :enrollments

end
