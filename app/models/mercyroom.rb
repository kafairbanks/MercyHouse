class Mercyroom < ApplicationRecord
  has_one :mercyhome
  has_many :bookings
  has_many :reports

  validate :house_exists

  validates_presence_of :mercyhomes_id, :RoomName

  private 

  # Finds the Mercy Home by their ID and checks that it exists
  def house_exists
    if !Mercyhome.exists?(self.mercyhomes_id)
      errors.add(:mercyhomes_id, 'Mercy Home does not exist.')
    end
  end



end
