class Applicant < ApplicationRecord
    has_many :bookings
    has_many :applications
    has_many :reports
    has_one :user

    validates_presence_of :AName, :AEmail
    validates :AEmail, format: { with: URI::MailTo::EMAIL_REGEXP , :message => " - Applicant email needs to be valid." } 

    def setStatusBackgroundCheckApproved
      applications = Application.where("applicants_id = #{self.id} AND \"ApplicationStatus\" = 'Submitted'")

      applications.each do |app|
        app.update!(ApplicationStatus: "Background Check Approved")
      end
    end

    def removeBackgroundCheckApproved
      applications = Application.where("applicants_id = #{self.id} AND \"ApplicationStatus\" = 'Background Check Approved'")

      applications.each do |app|
        app.update!(ApplicationStatus: "Submitted")
      end
    end

    def setStatusBooking
      applications = Application.where("applicants_id = #{self.id} AND \"ApplicationStatus\" = 'Background Check Approved'")

      applications.each do |app|
        app.update!(ApplicationStatus: "Booked")
      end
    end
end
