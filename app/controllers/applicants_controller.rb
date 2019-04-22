class ApplicantsController < AuthenticationController
  before_action :set_applicant, only: [:show, :edit, :update, :destroy]
  before_action :is_admin, only: [:destroy, :index]
  before_action :is_correct_applicant, only: [:edit, :update, :show]
  # GET /applicants
  # GET /applicants.json
  def index
    if params['name']
      @applicants = Applicant
                        .where('lower("AName") LIKE ?', "%#{params['name'].downcase}%")
    else
      @applicants = Applicant.all
    end

    @applicants = @applicants.reorder(Arel.sql('"AName"'))

    ppHash = Hash.new
    ppHash['10'] = 10
    ppHash['25'] = 25
    ppHash['50'] = 50
    @per_page_hash = ppHash


    if params[:per_page].nil? || params[:per_page].empty?
      params[:per_page] = 10
    end

    if @applicants.all.to_a.length >= 10
      @applicants = @applicants.all.paginate(page: params[:page], per_page: params[:per_page])
    end

  end

  # GET /applicants/1
  # GET /applicants/1.json
  def show
  end

  # GET /applicants/new
  def new
    @applicant = Applicant.new
  end

  # GET /applicants/1/edit
  def edit
  end

  # POST /applicants
  # POST /applicants.json
  def create
    @applicant = Applicant.new(applicant_params)

    begin
      if @applicant.save!
        applicants_id = @applicant.id
        session[:applicants_id] = applicants_id

        # Admins can create a new applicant and be redirected to the calendar (which is the current dashboard for them)
        if session[:user_role] == "admin"
          redirect_to calendar_path
        # Applicants the first time they login must give us their information and it'll update their applicant id so next time they login they won't have
        # to do it again. Afterwards they can be redirected to the patient dashboard
        else
          User.find(session[:user_id]).update(applicantid: applicants_id)
          session[:finished_signin] = 1
          redirect_to show_dash_path
        end

      end
    rescue
      render :new
    end

  end

  # PATCH/PUT /applicants/1
  # PATCH/PUT /applicants/1.json
  def update
    if applicant_params["BackgroundCheckCompleted"] == "1" or applicant_params["BCWaived"] == "1"
      @applicant.setStatusBackgroundCheckApproved
    elsif applicant_params["BackgroundCheckCompleted"] == "0" or applicant_params["BCWaived"] == "0"
      @applicant.removeBackgroundCheckApproved
    end


    respond_to do |format|
      begin
        if applicant_params["BackgroundCheckCompleted"] == "1" and (applicant_params["BackgroundCheckDate"].nil? or applicant_params["BackgroundCheckDate"].empty?)
          format.html { redirect_to edit_applicant_path(@applicant), notice: 'Please fill in a Background Check Completion Date.' }
        elsif @applicant.update!(applicant_params)
          format.html { redirect_to @applicant, notice: 'Applicant was successfully updated.' }
          format.json { render :show, status: :ok, location: @applicant }
        end
      rescue
        format.html { render :edit }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicants/1
  # DELETE /applicants/1.json
  def destroy

    # Only want to delete applications and bookings upon successfully deleting applicant
    if @applicant.destroy

      # Delete all of an applicants applications 
      Application.all.each do |app|
        if @applicant.id == app.applicants_id
          app.destroy
        end
      end


      # Delete all of an applicants bookings 
      Booking.all.each do |book| 
        if @applicant.id == book.applicants_id
          book.destroy
        end
      end
    
      # If an applicant is deleted, next time they log in it will try to find their dashboard path using their applicant id so we need to delete it.
      user_to_delete = User.find_by(applicantid: @applicant.id)
      if user_to_delete.present?
        user_to_delete.destroy
      end

    end

    respond_to do |format|
      format.html { redirect_to applicants_url, notice: 'Applicant and all associated bookings and applications were successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicant
      @applicant = Applicant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def applicant_params
      params.require(:applicant).permit(:name, :AName, :AEmail, :AMinor, :AAge, 
                                        :CareGiverID, :CGName, :CGHomePhone, :CGCellPhone, 
                                        :CGAddress, :CGCity, :CGState, :CGZip, :CGEmail, 
                                        :SPName, :SPHomePhone, :SPCellPhone, :SPAddress, 
                                        :SPCity, :SPState, :SPZip, :SPEmail, :EC1Name, :EC1HomePhone, 
                                        :EC1CellPhone, :EC1Address, :EC1City, :EC1State, :EC1Zip, 
                                        :EC1Email, :EC2Name, :EC2HomePhone, :EC2CellPhone, :EC2Address, 
                                        :EC2City, :EC2State, :EC2Zip, :EC2Email, :allowsUseOfName, :redFlag, 
                                        :redFlagReason, :BackgroundCheckDate, :BackgroundCheckCompleted, :canSubmitApplication,
                                        :RedFlagReason, :BCWaived, :BCReason)
    end
end
