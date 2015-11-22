class Api::V1::StudentsController < ApplicationController

  respond_to :json

  # GET /students/1
  # GET /students/1.json
  def show
  end

  def index
    puts "Fetching student with params: first_name: #{params[:first_name]}, last_name: #{params[:last_name]}, file_number: #{params[:file_number]}"
    @students = Student.where(:first_name => params[:first_name], :last_name => params[:last_name], :file_number => params[:file_number])
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    @student = Student.find(params[:id])
    student_params = Hash.new
    student_params[:regid] = params[:regid]

    if @student.update(student_params)
      puts "\n\n\n\n\n\n\nWill respond with #{@student}\n\n\n\n\n\n\n\n"
      respond_with @student
    else
      puts "\n\n\n\n\n\n\nWill respond with #{@student.errors}\n\n\n\n\n\n\n\n"
      respond_with @student.errors
    end
  end

  private
    def validate_student_personal_info
      @student = Student.where(:first_name => params[:first_name], :last_name => params[:last_name], :file_number => params[:file_number]).first
    end

end
