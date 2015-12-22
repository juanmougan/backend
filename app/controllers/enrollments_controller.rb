class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]

  # GET /enrollments
  # GET /enrollments.json
  def index
    if params[:student_id]
      @enrollments = Enrollment.where student_id: params[:student_id]
      @student = Student.find params[:student_id]
    else
      @enrollments = Enrollment.all
    end

  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    puts "\n\n\n\nParams in new are: #{params.inspect}\n\n\n\n"
    @enrollment = Enrollment.new
    #@student_for_enrollment =  Student.find(params[:student_for_enrollment])
    @student_for_enrollment =  Student.find(params[:student])
    @enrollment.student =  @student_for_enrollment
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments
  # POST /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)
    @enrollment.student =  Student.find(params[:student_for_enrollment])
    @enrollment.subject =  Subject.find(params[:subject])
    @enrollment.year = DateTime.now.year

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to '/students', notice: 'La Cursada se creó exitosamente.' }
        format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { render :new }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # FIXME: this method SHOULD NOT be used for now. Check if makes sense to edit an Enrollment (recursante?)
  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    @enrollment.student =  @student_for_enrollment
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to '/students', notice: 'La Cursada se actualizó exitosamente.' }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to '/students', notice: 'La Cursada se borró exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params[:enrollment].permit(:professorship, :shift)
    end
end
