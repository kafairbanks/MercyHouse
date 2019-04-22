class ChangeDatetimetoDate < ActiveRecord::Migration[5.2]
  def change
    change_column :applications, :ApplicationDate, :date
    change_column :applications, :ArrivalDate, :date
    change_column :applications, :DepartureDate, :date
    change_column :bookings, :StartDate, :date
    change_column :bookings, :EndDate, :date
    change_column :reports, :dstart, :date
    change_column :reports, :dend, :date
  end
end
