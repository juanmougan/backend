class FlatStudent < ActiveRecord::Base

	# attr_accessor :csv_id, :first_name, :last_name, :file_number, :career

	# This didn't work
	def wont_use_this(init)
		init.each_pair do |key, val|
			instance_variable_set('@' + key.to_s, val)
    	end
  	end

end
