class ChangeEC1StateToEc1State < ActiveRecord::Migration[5.2]
  def change
    rename_column :applicants, :ECIState, :EC1State
  end
end
