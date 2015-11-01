class SubscriptionList < ActiveRecord::Base
  #belongs_to :student
  has_and_belongs_to_many :students
  belongs_to :notification
end
