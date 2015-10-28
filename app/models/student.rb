class Student < ActiveRecord::Base
  belongs_to :career
  #has_many :subscription_lists
  has_and_belongs_to_many :subscription_lists, :join_table => "students_subscription_lists", :association_foreign_key => "subscription_list_id"
  has_many :enrollments
  #has_many :notifications, through: :subscription_lists
  
  has_many :enrollments, inverse_of: :student
  has_many :subjects, through: :enrollments

end
