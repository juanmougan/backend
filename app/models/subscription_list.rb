class SubscriptionList < ActiveRecord::Base
  #belongs_to :student
  has_and_belongs_to_many :students
  has_one :notification

  # Finds a SubscriptionList by a given Career code.
  # Assumes only one SubscriptionList per Career.
  def self.find_by_career_code(career_code)
    sql = "select sl.*, c.code " +
      "from subscription_lists sl " + 
      "inner join students_subscription_lists ssl on sl.id = ssl.subscription_list_id " + 
      "inner join students s on ssl.student_id = s.id " + 
      "inner join careers c on s.career_id = c.id " + 
      "where c.code = #{career_code} " +     # TODO how about SQL injection here?
      "group by sl.id "
  	return SubscriptionList.find_by_sql(sql)
  end

  # Finds a list of SubscriptionList by a given Subject code.
  def self.find_by_subject_code(subject_code)
  	sql = "select sl.*, sub.code " + 
    "from subscription_lists sl " + 
    "inner join students_subscription_lists ssl on sl.id = ssl.subscription_list_id " + 
    "inner join students s on ssl.student_id = s.id " + 
    "inner join enrollments e on s.id = e.student_id " + 
    "inner join subjects sub on e.subject_id = sub.id " + 
    "where sub.code = #{subject_code} " + 
    "group by sl.id "
    return SubscriptionList.find_by_sql(sql)
  end

end
