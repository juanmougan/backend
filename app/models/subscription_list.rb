class SubscriptionList < ActiveRecord::Base
  #belongs_to :student
  has_and_belongs_to_many :students
  has_one :notification

  # Finds a SubscriptionList by a given Career code.
  # Assumes only one SubscriptionList per Career.
  def self.find_by_career_code(career_code)
  	# TODO needs to be implemented
  	sl = SubscriptionList.first
  	puts "\n\n\n\n\n\n\nfind_by_career_code\n\n\n\n\n\n\n\n"
  	puts "\n\n\n\n\n\n#{sl}\n\n\n\n\n\n\n\n"
  	puts "\n\n\n\n\n\n#{sl.students}\n\n\n\n\n\n\n\n"
  	puts "\n\n\n\n\n\n#{sl.students.class}\n\n\n\n\n\n\n\n"
  	sl.students.each{|s| puts s}
  	return sl
  end

  def self.find_by_subject_name(subject_name)
  	# TODO needs to be implemented
  end

end
