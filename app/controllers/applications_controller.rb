class ApplicationsController < AuthenticationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]
  before_action :set_update, only: [:update, :destroy]

  # Make sure only admins see the index, can update an app, or destroy
  before_action :is_admin, only: [:index, :update, :destroy]
  before_action :is_correct_application, only: [:show]

  # GET /applications
  # GET /applications.json
  def index
    bHash = Hash.new
    bHash['Pending'] = false
    bHash['Booked'] = true
    @booked_options = bHash

    params[:show_booked]='false' if params[:show_booked].nil?

    if params[:commit] == 'Clear' and !params[:name].nil?
      params.delete(:name)
    end

    @applications = Application.joins(
        ActiveRecord::Base::sanitize_sql('INNER JOIN applicants ON applicants.id=applications.applicants_id')
        ).select('applicants."AName", applicants."redFlag", applicants."BackgroundCheckCompleted",
        applicants."BackgroundCheckDate", applicants."BCWaived", applications.*')
        .order(Arel.sql('"ApplicationDate" DESC'))

    @applications = @applications.reorder(Arel.sql('"ApplicationDate" DESC'))

    # puts Application.all.inspect

    if !params[:show_booked].nil? and !params[:show_booked].empty?
      @applications = @applications.where('booked=?', params[:show_booked])
      if params[:show_booked] == 'false'
        @applications = @applications.reorder(Arel.sql('"ApplicationDate" ASC'))
      end
    end

    if !params[:name].nil? and !params[:name].empty?
      @applications = @applications.where('lower(applicants."AName") LIKE ?', "%#{params[:name].downcase}%")
      @applications = @applications.reorder(Arel.sql('"ApplicationDate" DESC'))
    end

    ppHash = Hash.new
    ppHash['10'] = 10
    ppHash['25'] = 25
    ppHash['50'] = 50
    @per_page_hash = ppHash

    if params[:per_page].nil? || params[:per_page].empty?
      params[:per_page] = 10
    end

    if @applications.all.to_a.length >= 10
      @applications = @applications.all.paginate(page: params[:page], per_page: params[:per_page])
    end

  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @application = Application.new
    # puts("HERE IS PARAMS::::::::::::::::::::::::")
    @current_id = session[:applicants_id]
    session[:applicants_id] = @current_id
    # puts(@current_id)
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    if application_params.has_key?(:applicants_id) && (application_params[:applicants_id] != "")
      @application = Application.new(application_params)
    else
      @new_hash = application_params
      @new_hash["applicants_id"] = session[:applicants_id]
      @application = Application.new(@new_hash)
    end

    #check if applicant background check is already completed
    @applicant = Applicant.find(@application.applicants_id)
    if @applicant.BackgroundCheckCompleted or @applicant.BCWaived
      @application.ApplicationStatus = "Background Check Approved"
    end

    begin
        @application.save!
        redirect_to '/success'
    rescue
      # puts @application.pretty_inspect
      render :new and return
    end

    # MAIL STUFF HERE
    @applicant = Applicant.find(@application.applicants_id)
    @applicant.update(canSubmitApplication: false)
    ApplicantMailer.successful_submission_email(@applicant).deliver_now

    if @applicant.redFlag
      AdminMailer.applicant_redflag_notice(@applicant, @application).deliver_now
    else
      AdminMailer.applicant_submitted_email(@applicant, @application).deliver_now
    end

  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy

    if @application.destroy
      # Delete the booking associated with application
      booking = Booking.find_by(application_id: @application.id)
      if !booking.nil?
        booking.destroy
      end
    end

    respond_to do |format|
      format.html { redirect_to applications_url, notice: 'Application was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      join_arg = 'INNER JOIN applicants ON applicants.id=applications.applicants_id
            AND applications.id=' + params[:id].to_s
      @application = Application
                         .joins(ActiveRecord::Base::sanitize_sql(join_arg))
                         .select('applicants."AName", applicants."BackgroundCheckCompleted",
                            applicants."BackgroundCheckDate", applicants."BCWaived", applications.*')
                         .first()
    end

    def set_update
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:applicants_id, :ApplicationDate, :ApplicationStatus, :HospitalName,
                                          :DoctorName, :TreatmentPlan, :appliedForLongTermHousing, :where,
                                          :LongTermHousing, :prayerRequests, :isFirstVisit, :wantsInfo,
                                          :insuranceCoversHousing, :futureScheduledAppts, :ArrivalDate,
                                          :DepartureDate, :lockApplication, :booked)
    end
end
