class Renamedataquotation < ActiveRecord::Migration[6.0]
  def change
    rename_column :quotations, :cargo_type, :mode_of_shipment
  end
end
