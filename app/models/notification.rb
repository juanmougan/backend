class Notification < ActiveRecord::Base
	has_one :subscription_list
	#has_many :students, through: :subscription_list
end
