class ApplicantMailer < ApplicationMailer

  def successful_submission_email(applicant)
    @applicant = applicant
    @url = url_for(action: 'show_dash', controller: 'applicant_dash', applicants_id: @applicant.id)
    mail(:to => @applicant.AEmail, :subject => "Successfully received application.")
  end

  def new_booking_alert(coordinator, mercyhouse, mercyroom, booking, applicant )
    @coordinator = coordinator
    @applicant = applicant
    @mercyhome = mercyhouse
    @mercyroom = mercyroom
    @booking = booking
    mail(:to => @applicant.AEmail, :subject => "New booking notice.")
  end

end
