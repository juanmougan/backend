class Notification < ActiveRecord::Base
	has_one :subscription_list
	#has_many :students, through: :subscription_list

	after_save :post_gcm_notification, on: :create

	protected
		def post_gcm_notification
			# TODO add "real" support - Grab the regids for the Students in the SL
			# For now, it's hardcoded
			regids = Array.new
			regids << "APA91bGSNWN8FzqGygEyuPyn370Juuwiyzy3KyQYv7h5UbHpfkUyMzEPqsc2fuKGiu9Lbg2U9iwocFliqGuTDJBdbNgGT_C5YVw4NybcYF-EIcloYqY3i3jHXEQlCSmyiEXQ2xxfV29k9M2o-V0prAefNTjyu2ldw-tqPgw18D3PxECPpDyZFD0"
			regids << "APA91bEqiE5gHfB5uvWMno6TA6J53EMs1srn3xOU04Xdy3cCXqnRXKIibAvZUNT4GYKQ_ej2zaROia09WYq_DPo5O-tQLqihJrSwKrMQn1ySx0nGbuq2VqJntLztpqDFt9BPcC_Z4j5PuFJibFa-xKk9YuaUyVgWGd7PaR4nBucw9gc2x4QD3XA"
			regids << "APA91bGGMJMI5es9sWU0QPk4N-jc-teovBLTzw-258iDnQGrFw603qnaQx2UNfqRRfKZlMKLJOFOWOkFZCRGQH-ddAfF95NHBTKeC82zrhDuVejo7D5kI_D-Ub4uAa2eeVTgtvQOkvNt1Eo6iUzXyRv3tH9sq6wUHS4f9Y79TB6g5lzJ734bR08"
			regids << "APA91bHjqCPinPtVB8XFMHAJrZNkju8C-ZETyZHvhFc9Ai_3I50Mpdz34-8GePHEm2G3TxSOcvXI4oOJlzvvWcKTrILczycL5cey4miPvVcKZf5oue-IGYQQ99RNLCvvb39yf5F7_DyEUhg5VemM6BkPqWF2_DMb9g"
			regids << "APA91bENNzCBAMCqPsBMV0tDnN7F7dUMXYpTs71ti9jYWHjPRVjn2DL4YTDKVdtYJ_SISe59hQy933QwC1qbcTf93tzC7Wrvk4wD8GIyXZh2MthdJfOYMNwR2oR2tf0ikpS2L3tIPqyXkgbnV4FWdFlArTm2Quav7A"
			
			result = GcmSenderJob.perform_later(regids)
			puts "\n\n\n\nJob returned: #{result}\n\n\n\n"
		end

end
