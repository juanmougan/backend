class StudentController < ApplicationController
  def index
  	@students = Student.all
  	respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @students }	# student/index.json
    end
  end
end
