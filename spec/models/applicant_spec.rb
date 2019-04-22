require 'rails_helper'

def create_applicants_application(app_id)
  app_params = {
      applicants_id: app_id,
      ApplicationDate: "2012-02-05",
      ArrivalDate: "2012-04-20",
      DepartureDate: "2012-04-24",
      HospitalName: 'Memorial Hermann',
      DoctorName: 'Dr. Pepper',
      ApplicationStatus: "Submitted"
  }
  Application.create!(app_params)
end

def create_applicant
  app_params = {
      AName: "New Davis",
      AEmail: "AlexDavy@dishmail.heroku",
      AMinor: false,
      SPHomePhone: "5154143113",
      SPAddress: "907 Cross Street",
      SPCity: "College Station",
      SPState: "TX",
      SPZip: "77840",
      SPEmail: "itsjeff@hotmail.net",
      BackgroundCheckCompleted: true,
      BackgroundCheckDate: '2019-04-08'
  }
  Applicant.create!(app_params)
end

RSpec.describe Applicant, type: :model do

  describe 'setStatusBackgroundCheck' do

    context 'of a new application' do
      it 'should set the application status to "Background Check Approved"' do
        applicant = create_applicant
        application = create_applicants_application(applicant.id)
        applicant.setStatusBackgroundCheckApproved
        application.reload

        expect(application.ApplicationStatus).to eq("Background Check Approved")
      end
    end

  end

  describe 'removeBackgroundCheckApproved' do

    context 'of a new application' do
      it 'should set the application status to "Submitted"' do
        applicant = create_applicant
        application = create_applicants_application(applicant.id)
        applicant.setStatusBackgroundCheckApproved
        application.reload
        applicant.removeBackgroundCheckApproved
        application.reload

        expect(application.ApplicationStatus).to eq("Submitted")
      end
    end

  end

  describe 'setStatusBooking' do

    context 'of a new application' do
      it 'should set the application status to "Booked"' do
        applicant = create_applicant
        application = create_applicants_application(applicant.id)
        applicant.setStatusBackgroundCheckApproved
        application.reload
        applicant.setStatusBooking
        application.reload

        expect(application.ApplicationStatus).to eq("Booked")
      end
    end

  end

end
