class AddApplicantIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :applicantid, :integer, :default => -1
  end
end
