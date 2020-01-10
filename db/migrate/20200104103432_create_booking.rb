class CreateBooking < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.string  :file_booking
      t.string  :booking_number
      t.string  :flight_number
      t.string  :vessel
      t.string  :status
      t.timestamps
      t.references :quotation, foreign_key: true
    end
  end
end
