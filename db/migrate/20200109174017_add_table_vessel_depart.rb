class AddTableVesselDepart < ActiveRecord::Migration[6.0]
  def change
    create_table :vessel_departs do |t|
      t.string  :status
      t.references :quotation, foreign_key: true
      t.timestamps
    end
  end
end
