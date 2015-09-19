class Notification < ActiveRecord::Base
	has_many :students, through: :subscription_list
end
