class AddProcessedToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :processed, :boolean, default:false, null:false
  end
end
