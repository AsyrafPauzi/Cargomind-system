class DropBillToBilling < ActiveRecord::Migration[6.0]
  def change
    remove_column :billing_details, :cost
    remove_column :billing_details, :bill
    remove_column :billing_details, :profit
    add_column :billing_details, :cost, :decimal, :precision => 9, :scale => 2, :default => '0.00'
    add_column :billing_details, :bill, :decimal, :precision => 9, :scale => 2, :default => '0.00'
    add_column :billing_details, :profit, :decimal, :precision => 9, :scale => 2, :default => '0.00'
  end
end
