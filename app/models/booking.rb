class Booking < ApplicationRecord
  has_one :applicant
  has_one :mercyroom
  has_many :reports

  validate :overlapping
  validate :backgroundCheckComplete

  validates :applicants_id, :presence => true
  validates :mercyrooms_id, :presence => true
  validates :StartDate, :presence => true
  validates :EndDate, :presence => true

  def start_time
    self.StartDate
  end

  def end_time
    self.EndDate
  end

  def get_applicant
    return Applicant.find(self.applicants_id)
  end

  private
  def overlapping
    if Booking.where('? <  "EndDate" and ? > "StartDate" and mercyrooms_id = ?', self.StartDate, self.EndDate, self.mercyrooms_id).any?
      errors.add(:EndDate, 'Booking overlaps with another reservation')
    end
  end

  def backgroundCheckComplete
    applicant = get_applicant
    if (applicant.BackgroundCheckCompleted == false) && !(applicant.BCWaived)
      errors.add(:applicants_id, 'Applicant\'s background check incomplete')
    end
  end
end
