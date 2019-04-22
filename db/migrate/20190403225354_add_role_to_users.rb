class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string, :limit => 10, :default => "user"
  end
end
