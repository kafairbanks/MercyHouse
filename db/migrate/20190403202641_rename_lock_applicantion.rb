class RenameLockApplicantion < ActiveRecord::Migration[5.2]
  def change
    rename_column :applications, :lockApplicantion, :lockApplication
  end
end
