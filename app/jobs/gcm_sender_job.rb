require 'gcm'
require 'yaml'
require 'pp'

class GcmSenderJob < ActiveJob::Base
  queue_as :default

  GCM_LIMIT = 1000			# If we do some fix to broadcast to more than 1000 receivers, this should be removed
  RAILS_ROOT = Rails.root.to_s
  
  def check_arguments(args)
    if args.length < 1 || args.length > GCM_LIMIT
      raise RuntimeError, "At least one regid needed"
    end
  end

  def perform(*args)
    puts "\n\n\n\n\nArgs received - class: #{args.class}"
    pp args
    notification = args.shift
    puts "\n\n\n\n\nNotification received - class: #{notification.class}"
    pp notification
    regids = args.shift    #asignar esto a una var
    puts "\n\n\n\n\nregids arew now - class: #{regids.class}"
    pp regids
  	check_arguments(regids)
    api_key = YAML.load_file("#{RAILS_ROOT}/config/api_key.yml")
    gcm = GCM.new(api_key)
    message = { 
    	data: {
	      gcmTitulo: notification[:title],
	      gcmMensaje: notification[:message]
	    }
    }
    # TODO add support for more than 1000 receivers
    puts "\n\n\n\nAbout to send to: #{regids}\n\n\n\n"
    response = gcm.send(regids, message)
    puts "\n\n\n\nReceived this from GCM:\n"
    pp response  
  end
end
