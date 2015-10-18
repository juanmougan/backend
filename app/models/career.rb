class Career < ActiveRecord::Base
  has_many :subjects
  has_many :students
end
