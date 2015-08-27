class CsvImporterController < ApplicationController
  def index
    # TODO here should show the upload file form
  end

  def import_csv
  	# TODO pass the CSV here
  	#CsvImporterJob.perform_later(params[:input_file])
  	
  	#if params[:filename].nil?
  	#	raise RuntimeError, "Missing filename"
  	#end

  	Rails.logger.debug params.inspect

  	path = get_file_name(params[:filename], params[:input_file])
  	CsvImporterJob.perform_later(path)

  	# TODO can the job return a Students Hash? And use it here to create the Students?
  end

  private
    def get_file_name(file_name, incoming_file)
      #path = "/home/juanma/dev/ceiuca/backend/public/#{file_name}"
      root_path = Rails.root.to_s
      path = "#{root_path}/public/#{file_name}"
      FileUtils.cp incoming_file.tempfile, path
      return path
    end

end
