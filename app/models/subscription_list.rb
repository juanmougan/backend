class SubscriptionList < ActiveRecord::Base
  #belongs_to :student
  has_and_belongs_to_many :students, :join_table => "students_subscription_lists", :association_foreign_key => "student_id"
  belongs_to :notification
end
