class Professor < ActiveRecord::Base
	has_many :assignments
	has_many :subjects, through: :assignments
end
