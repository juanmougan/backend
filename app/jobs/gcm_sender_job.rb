require 'gcm'
require 'yaml'
require 'pp'

class GcmSenderJob < ActiveJob::Base
  queue_as :default

  GCM_LIMIT = 1000			# If we do some fix to broadcast to more than 1000 receivers, this shhould be removed
  API_KEY_FILE = "api_key.yaml"

  
  def check_arguments
    if ARGV.length < 1 || ARGV.length > 1000
      raise RuntimeError, "At least one regid needed"
    end
  end

  def perform(*args)
  	check_arguments
  	api_key = YAML.load_file(API_KEY_FILE)
    gcm = GCM.new(api_key)
    options = { 
    	data: {
	      gcmTitulo: "GCM Notifications",
	      gcmMensaje:"Testing the Gem"
	    }
    }
    # TODO add support for more than 1000 receivers
    puts "About to send to: #{ARGV}"
    response = gcm.send(ARGV, options)
    pp response
  end
end
