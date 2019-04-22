class Coordinator < ApplicationRecord
  validates_presence_of :HCName
  validates :HCEmail, format: { with: URI::MailTo::EMAIL_REGEXP , :message => " - Coordinator email needs to be valid." } 

  def self.get_all_coords
    return Coordinator.all.pluck(:HCName, :id).map
  end

end
