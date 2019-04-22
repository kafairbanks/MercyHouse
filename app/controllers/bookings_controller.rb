class BookingsController < AuthenticationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  # Only admins can see anything for bookings
  before_action :is_admin

  # GET /bookings
  # GET /bookings.json
  def index
    bHash = Hash.new
    bHash['Current'] = 'Current'
    bHash['Upcoming'] = 'Upcoming'
    bHash['Previous'] = 'Previous'
    @booked_statuses = bHash

      @bookings =
        Booking
            .select('bookings.*, mercyrooms."RoomName", mercyhomes."HouseName", applicants."AName"')
            .joins('INNER JOIN mercyrooms ON mercyrooms.id=bookings.mercyrooms_id')
            .joins('INNER JOIN mercyhomes ON mercyhomes.id=mercyrooms.mercyhomes_id')
            .joins('INNER JOIN applicants ON applicants.id=bookings.applicants_id')
            .order(Arel.sql('"StartDate" DESC'))

    if !(params['name'].nil? || params['name'].empty?)
      @bookings = @bookings.where('lower("AName") LIKE ?', "%#{params['name'].downcase}%")
    end

    @bookings = @bookings.reorder(Arel.sql('"StartDate" DESC'))

    if !(params[:status_filter].nil? or params[:status_filter].empty?)
      case params[:status_filter]
      when 'Current'
          @bookings = @bookings.where('? <= "EndDate" and ? >= "StartDate"', Date.today, Date.today)
          @bookings = @bookings.reorder(Arel.sql('"StartDate" ASC'))
      when 'Upcoming'
          @bookings = @bookings.where('? < "StartDate"', Date.today)
          @bookings = @bookings.reorder(Arel.sql('"StartDate" ASC'))
      when 'Previous'
          @bookings = @bookings.where('? > "EndDate"', Date.today)
      end
    end

    ppHash = Hash.new
    ppHash['10'] = 10
    ppHash['25'] = 25
    ppHash['50'] = 50
    ppHash['100'] = 100
    @per_page_hash = ppHash

    if params[:per_page].nil? || params[:per_page].empty?
      params[:per_page] = 10
    end

    if @bookings.all.to_a.length >= 10
      @bookings = @bookings.all.paginate(page: params[:page], per_page: params[:per_page])
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    sd = Date.today
    ed = Date.today + 1.day
    @start_date = sd.strftime("%Y-%m-%d")
    @end_date = ed.strftime("%Y-%m-%d")

    if !params[:id].nil? and !params[:id].empty?
      application_id = params[:id]
    elsif !params[:booking].nil? and !params[:booking].empty?
      application_id = params[:booking][:application_id]
    end

    if !application_id.nil?
      # If we have an application id, use its info
      # puts Application.all.pretty_inspect
      @application = get_application(application_id)
      sd = Date.parse(@application.ArrivalDate.to_s)
      ed = Date.parse(@application.DepartureDate.to_s)
      @start_date = sd.strftime("%Y-%m-%d")
      @end_date = ed.strftime("%Y-%m-%d")
    end

    if !params[:StartDate].nil? and !params[:EndDate].nil?
      # Overwrite that info with parameters given
      sd = Date.parse(params[:StartDate].to_s)
      ed = Date.parse(params[:EndDate].to_s)
      @start_date = sd.strftime("%Y-%m-%d")
      @end_date = ed.strftime("%Y-%m-%d")
    end

    if @start_date >= @end_date
      @start_date = Date.parse(@application.ArrivalDate.to_s)
      @end_date = Date.parse(@application.DepartureDate.to_s)
    end

    @filtered_rooms = Mercyroom
                          .select('mercyrooms.*, mercyhomes."HouseName"')
                          .joins('INNER JOIN mercyhomes ON mercyhomes.id=mercyhomes_id')
                          .where('mercyrooms.id NOT IN
                                  (SELECT mercyrooms_id FROM bookings
                                  WHERE ? <  "EndDate" and ? > "StartDate")', @start_date, @end_date)
                          .order('mercyrooms.id')

    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
    @start_date = @booking.StartDate
    @end_date = @booking.EndDate

    if !params[:StartDate].nil? and !params[:EndDate].nil?
      # Overwrite that info with parameters given
      sd = Date.parse(params[:StartDate].to_s)
      ed = Date.parse(params[:EndDate].to_s)
      @start_date = sd.strftime("%Y-%m-%d")
      @end_date = ed.strftime("%Y-%m-%d")
    end

    @filtered_rooms = Mercyroom
                          .select('mercyrooms.*, mercyhomes."HouseName"')
                          .joins('INNER JOIN mercyhomes ON mercyhomes.id=mercyhomes_id')
                          .where('mercyrooms.id NOT IN
                                  (SELECT mercyrooms_id FROM bookings
                                  WHERE ? <  "EndDate" and ? > "StartDate")', @start_date, @end_date)
                          .order('mercyrooms.id')
  end

  # POST /bookings
  # POST /bookings.json
  def create
    temp_params = booking_params

    if temp_params[:mercyrooms_id] != '' and temp_params[:applicants_id] != '' and temp_params[:application_id] != ''
      temp_params[:mercyrooms_id] = temp_params[:mercyrooms_id].to_i
      temp_params[:applicants_id] = temp_params[:applicants_id].to_i
      temp_params[:application_id] = temp_params[:application_id].to_i
    end

    @booking = Booking.new(temp_params)
    respond_to do |format|
      begin
        if @booking.save!
          begin
            application = Application.where('id=?', temp_params[:application_id]).first()
            application.update!({:booked => true})
          end

          @applicant = Applicant.find(temp_params[:applicants_id])
          @mercyroom = Mercyroom.find(temp_params[:mercyrooms_id])
          @mercyhouse = Mercyhome.find(@mercyroom.mercyhomes_id)
          @coordinator = Coordinator.find(@mercyhouse.coordinators_id)

          @applicant.setStatusBooking

          CoordinatorMailer.new_booking_alert(@coordinator, @mercyhouse , @mercyroom, @booking, @applicant).deliver_now
          ApplicantMailer.new_booking_alert(@coordinator, @mercyhouse, @mercyroom, @booking, @applicant).deliver_now
          format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
          format.json { render :show, status: :created, location: @booking }
        end
      rescue
        format.html { redirect_to app_booking_path(id: temp_params[:application_id]), notice: 'Booking failed.'}
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      begin
        if @booking.update!(booking_params)
          format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
          format.json { render :show, status: :ok, location: @booking }
        end
      rescue
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    if @booking.destroy
      @application = Application.find(@booking.application_id)
      applicant = Applicant.find(@application.applicants_id);
      application_status = "Submitted"
      if applicant.BackgroundCheckCompleted
        application_status = "Background Check Approved"
      end
      @application.update(booked: false, ApplicationStatus: application_status)
    end

    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking =
          Booking
              .select('bookings.*, mercyrooms."RoomName", mercyhomes."HouseName", applicants."AName"')
              .joins('INNER JOIN mercyrooms ON mercyrooms.id=bookings.mercyrooms_id')
              .joins('INNER JOIN mercyhomes ON mercyhomes.id=mercyrooms.mercyhomes_id')
              .joins('INNER JOIN applicants ON applicants.id=bookings.applicants_id')
              .where(ActiveRecord::Base::sanitize_sql("bookings.id=#{params[:id]}"))
              .first()
    end

    def set_booking_form

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:applicants_id, :application_id, :mercyrooms_id, :StartDate, :EndDate)
    end

    def get_application(app_id)
      Application
        .select('applications.*, applicants."AName", applicants."BackgroundCheckCompleted", applicants."BCWaived"')
        .joins('INNER JOIN applicants on applicants.id=applications.applicants_id')
        .where(ActiveRecord::Base::sanitize_sql(Arel.sql("applications.id=#{app_id}")))
        .order(Arel.sql('"ApplicationDate"'))
        .first()
    end

end
