class AddColorToMercyhomes < ActiveRecord::Migration[5.2]
  def change
    add_column :mercyhomes, :color, :string
  end
end
