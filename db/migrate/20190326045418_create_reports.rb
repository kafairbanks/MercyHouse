class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :mroomid
      t.string :mroomname, limit: 100
      t.datetime :dstart
      t.datetime :dend
      t.timestamp :created_on, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
