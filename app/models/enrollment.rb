class Enrollment < ActiveRecord::Base
  belongs_to :student, inverse_of: :enrollments
  belongs_to :subject, inverse_of: :enrollments
end
