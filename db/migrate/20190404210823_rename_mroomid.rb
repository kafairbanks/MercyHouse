class RenameMroomid < ActiveRecord::Migration[5.2]
  def change
    rename_column :reports, :mroomid, :mhomeid
    rename_column :reports, :mroomname, :mhomename
  end
end
