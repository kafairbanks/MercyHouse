class AddApplicationIdToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :application_id, :integer, null:false
  end
end
