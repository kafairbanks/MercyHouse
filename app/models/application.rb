class Application < ApplicationRecord
  # belongs_to :applicants
  has_one :applicant
  has_many :reports

  validate :reversedDates
  validate :afterToday

  validates_presence_of :applicants_id, :HospitalName

  def reversedDates
    if self.DepartureDate <= self.ArrivalDate
      errors.add(:ReversedDates, 'Departure Date must be after Arrival Date')
    end
  end

  def afterToday
    if self.ArrivalDate < Date.today
      errors.add(:StartDate, 'Arrival Date must be after today')
    end
  end

  def getProgress
    case self.ApplicationStatus
    when "Submitted"
      return 33
    when "Background Check Approved"
      return 67
    when "Booked"
      return 100
    else
      return 0
    end
  end
end
