class AddSubmitFieldToApplicants < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :canSubmitApplication, :boolean, default: false
  end
end
