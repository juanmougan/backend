class SubscriptionList < ActiveRecord::Base
  belongs_to :student
  belongs_to :notification
end
