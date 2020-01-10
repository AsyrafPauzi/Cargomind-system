class CreateCargoCollection < ActiveRecord::Migration[6.0]
  def change
    create_table :cargo_collections do |t|
      t.string  :file_rot
      t.string  :estimated_collection_date
      t.string  :truck_number
      t.string  :driver_name
      t.string  :driver_phone_number
      t.string  :truck_type
      t.string  :status
      t.string  :haulage
      t.timestamps
      t.references :quotation, foreign_key: true
    end
  end
end
