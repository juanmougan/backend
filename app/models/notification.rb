class Notification < ActiveRecord::Base
	belongs_to :subscription_list
	#has_many :students, through: :subscription_list

	after_save :post_gcm_notification, on: :create

	protected
		def post_gcm_notification
			postable_message = {
					:title => self.title,
					:message => self.message
				}
			regids = self.subscription_list.students.map{|s| s.regid}.compact
			puts "\n\n\n\nThe regids: #{regids}\n\n\n\n"
			result = GcmSenderJob.perform_later(postable_message, regids)
			puts "\n\n\n\nJob returned: #{result}\n\n\n\n"
		end

end
