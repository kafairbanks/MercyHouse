class CoordinatorMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.coordinator_mailer.new_booking.subject
  #
  def new_booking_alert(coordinator, mercyhouse, mercyroom, booking, applicant )
    @coordinator = coordinator
    @applicant = applicant
    @mercyhome = mercyhouse
    @mercyroom = mercyroom
    @booking = booking
    mail(:to => @coordinator.HCEmail, :subject => "New booking notice.")
  end
end
