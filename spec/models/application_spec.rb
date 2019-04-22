require 'rails_helper'

def create_application(status)
  app_params = {
      applicants_id: 2,
      ApplicationDate: "2012-02-05",
      ArrivalDate: "2012-04-20",
      DepartureDate: "2012-04-24",
      HospitalName: 'Memorial Hermann',
      DoctorName: 'Dr. Pepper',
      ApplicationStatus: status
  }
  Application.create!(app_params)
end

RSpec.describe Application, type: :model do

  describe 'getProgress' do

    context 'of an incomplete application' do
      it 'should return 0' do
        application = create_application('Incomplete')
        expect(application.getProgress).to eq(0)
      end
    end

    context 'of a finished application' do
      it 'should return 33' do
        application = create_application('Submitted')
        expect(application.getProgress).to eq(33)
      end
    end

    context 'of a complete background check' do
      it 'should return 67' do
        application = create_application('Background Check Approved')
        expect(application.getProgress).to eq(67)
      end
    end

    context 'of a booked application' do
      it 'should return 100' do
        application = create_application('Booked')
        expect(application.getProgress).to eq(100)
      end
    end

  end
end
