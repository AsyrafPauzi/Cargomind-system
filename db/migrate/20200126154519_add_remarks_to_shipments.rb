class AddRemarksToShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :quotations, :remarks, :string
    add_column :quotations, :file_client, :string
  end
end
