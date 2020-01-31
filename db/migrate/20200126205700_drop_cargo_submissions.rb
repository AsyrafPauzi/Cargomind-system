class DropCargoSubmissions < ActiveRecord::Migration[6.0]
  def change
    drop_table :cargo_submissions
    drop_table :flight_departs
  end
end
