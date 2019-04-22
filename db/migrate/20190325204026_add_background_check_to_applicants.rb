class AddBackgroundCheckToApplicants < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :BackgroundCheckCompleted, :boolean, default: false
    add_column :applicants, :BackgroundCheckDate, :date
  end
end
