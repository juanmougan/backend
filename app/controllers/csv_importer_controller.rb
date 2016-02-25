class CsvImporterController < ApplicationController
  def index
    # TODO here should show the upload file form
  end

  def import_csv
    path = get_file_name(params[:input_file].original_filename, params[:input_file])
  	result = CsvImporterJob.perform_later(path)

    redirect_to '/students', notice: "Archivo CSV importado exitosamente."

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
