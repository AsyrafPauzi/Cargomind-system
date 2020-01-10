class Addremarkstocargocollection < ActiveRecord::Migration[6.0]
  def change
    add_column :cargo_collections, :lcl_remarks, :string
  end
end
