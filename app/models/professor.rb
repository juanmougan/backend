class Professor < ActiveRecord::Base
	has_many :subjects, through: :assignments
end
