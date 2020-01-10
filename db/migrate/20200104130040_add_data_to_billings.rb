class AddDataToBillings < ActiveRecord::Migration[6.0]
  def change
    add_reference :billings, :quotation, foreign_key: true
    add_column :billings, :status, :string
  end
end