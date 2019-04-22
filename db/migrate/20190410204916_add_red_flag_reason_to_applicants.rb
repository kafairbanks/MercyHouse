class AddRedFlagReasonToApplicants < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :RedFlagReason, :string
  end
end
