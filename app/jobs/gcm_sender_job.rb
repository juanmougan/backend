require 'gcm'
require 'yaml'
require 'pp'

class GcmSenderJob < ActiveJob::Base
  queue_as :default

  GCM_LIMIT = 1000			# If we do some fix to broadcast to more than 1000 receivers, this should be removed
  API_KEY_FILE = "api_key.yaml"
  
  def check_arguments(args)
    if args.length < 1 || args.length > GCM_LIMIT
      raise RuntimeError, "At least one regid needed"
    end
  end

  def perform(*args)
  	check_arguments(args)
    #api_key = YAML.load_file(API_KEY_FILE)     # TODO add support for reading key from YAML file
  	api_key = "AIzaSyBz4gpKatKkxZ1W6DpvaWJ66H2Hwdz7FIY"
    gcm = GCM.new(api_key)
    options = { 
    	data: {
	      gcmTitulo: "GCM Notifications - multiple regids",
	      gcmMensaje:"Testing the Gem from a Job"
	    }
    }
    # TODO add support for more than 1000 receivers
    args.each do |regid|
      puts "\n\n\n\nAbout to send to: #{regid}\n\n\n\n"
      response = gcm.send(regid, options)
      puts "\n\n\n\nReceived this from GCM:\n"
      pp response
    end
  end
end
