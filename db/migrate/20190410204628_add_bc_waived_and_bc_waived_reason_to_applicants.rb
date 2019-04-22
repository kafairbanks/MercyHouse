class AddBcWaivedAndBcWaivedReasonToApplicants < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :BCWaived, :boolean, default: false
    add_column :applicants, :BCReason, :string
  end
end
