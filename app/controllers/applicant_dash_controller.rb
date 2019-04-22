class ApplicantDashController < AuthenticationController
  
  def show_dash
    # puts("Showing the patient dashboard")

    if session[:user_role] == "admin"
      redirect_to calendar_path and return
    end

    @applicant = Applicant.find(session[:applicants_id])

    if(Application.exists?(applicants_id: session[:applicants_id]))
      @application = Application
                         .where("applicants_id = #{session[:applicants_id]}")
                         .order(Arel.sql('id DESC'))
                         .first()

      @booking = Booking.select('bookings.*, mercyrooms."RoomName", mercyhomes."HouseName", mercyhomes."HouseAddress",
                                  mercyhomes."HouseCity", mercyhomes."HouseState", mercyhomes."HouseZip", applicants."AName"')
                     .joins('INNER JOIN mercyrooms ON mercyrooms.id=bookings.mercyrooms_id')
                     .joins('INNER JOIN mercyhomes ON mercyhomes.id=mercyrooms.mercyhomes_id')
                     .joins('INNER JOIN applicants ON applicants.id=bookings.applicants_id')
                     .where("application_id = #{@application.id}").first()
    else
      redirect_to new_application_path(:applicants_id => session[:applicants_id])
    end
  end

end
