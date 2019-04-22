class ChangeBookedToProcessed < ActiveRecord::Migration[5.2]
  def change
    rename_column :applications, :processed, :booked
  end
end
