class SubscriptionListsController < ApplicationController
  before_action :set_subscription_list, only: [:show, :edit, :update, :destroy]

  # GET /subscription_lists
  # GET /subscription_lists.json
  def index
    @subscription_lists = SubscriptionList.all
  end

  # GET /subscription_lists/1
  # GET /subscription_lists/1.json
  def show
  end

  # GET /subscription_lists/new
  def new
    @subscription_list = SubscriptionList.new
  end

  # GET /subscription_lists/1/edit
  def edit
  end

  # POST /subscription_lists
  # POST /subscription_lists.json
  def create
    # TODO switch on "rule" value, and use the proper value in the Where
    puts "\n\n\n\n\n\n\n\n\nThese are the params: #{params.inspect}"
    puts "\n\n\n\n\nThis is subscription_list_params object: #{subscription_list_params.inspect}\n\n\nand its class #{subscription_list_params.class}\n\n\n\n"
    #@subscription_list = SubscriptionList.new(subscription_list_params)
    @subscription_list = SubscriptionList.new(subscription_list_params[:subscription_list])
    # TODO add a Where according to the rule
    # e.g. @subscription_lists = SubscriptionList.where(:id => params[:subscriptions])
    @subscription_list.students = get_students_from_rule_param
    puts "\n\n\n\n\n@subscription_list.students: #{@subscription_list.students.inspect}\n\n\nand its class #{@subscription_list.students.class}\n\n\n\n"

    respond_to do |format|
      if @subscription_list.save
        format.html { redirect_to @subscription_list, notice: 'Subscription list was successfully created.' }
        format.json { render :show, status: :created, location: @subscription_list }
      else
        format.html { render :new }
        format.json { render json: @subscription_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscription_lists/1
  # PATCH/PUT /subscription_lists/1.json
  def update
    @subscription_list.students = get_students_from_rule_param
    respond_to do |format|
      #if @subscription_list.update(subscription_list_params)
      if @subscription_list.update(subscription_list_params[:subscription_list])
        format.html { redirect_to @subscription_list, notice: 'Subscription list was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription_list }
      else
        format.html { render :edit }
        format.json { render json: @subscription_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscription_lists/1
  # DELETE /subscription_lists/1.json
  def destroy
    @subscription_list.destroy
    respond_to do |format|
      format.html { redirect_to subscription_lists_url, notice: 'Subscription list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def get_students_from_rule_param
      #subscription_list_params
      #"rule"=>"subject", "careers"=>"1", "subjects"=>"15"
      puts "\n\n\n\n\params[:rule]: #{params[:rule].inspect}\n\n\nand its class #{params[:rule].class}\n\n\n\n"

      case params[:rule]
        when "career"
          #puts "\n\n\n\n\nBy career: #{params[:career]}\nand its class #{params[:career]}\n\n\n\n"
          puts "\n\n\n\n\nBy career: #{params[:careers]}\nand its class #{params[:careers]}\n\n\n\n"
          puts "\n\n\n\nStudents found by career: #{Student.where(:career_id => params[:careers])}\n\n\n\n"
          return Student.where(:career_id => params[:careers])
        when "year"
          # TODO Subjects don't have a year like "1ro, 2do" or so. See https://github.com/juanmougan/backend/issues/10
          raise RuntimeError, 'Still not implemented'
        when "subject"
          enrollments = Enrollment.where(:subject_id => params[:subjects])
          puts "\n\n\n\nenrollments: #{enrollments.inspect}\n\n\nand its class #{enrollments.class}\n\n\n\n"
          student_ids = enrollments.map { |e| e.student_id }
          puts "\n\n\n\n\nstudent_ids: #{student_ids.inspect}\n\n\nand its class #{student_ids.class}\n\n\n\n"
          puts "\n\n\n\n\nArray's first element: #{student_ids[0].inspect}\n\n\nand its class #{student_ids[0].class}\n\n\n\n"
          #return Student.find_by_id(student_ids)      #find throws an exception if any record is not found
          return Student.where :id => student_ids
        end
        else
          # TODO handle default
      end

    # Use callbacks to share common setup or constraints between actions.
    def set_subscription_list
      @subscription_list = SubscriptionList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_list_params
      #params[:subscription_list].permit(:name, :description)
      #params.permit(:careers, :years, :subjects).permit(subscription_list: [ :name, :description ])
      #params.permit(:careers).require(:subscription_list).permit(:name, :description)
      params.permit!      # So far, no strong params here...
    end
end
