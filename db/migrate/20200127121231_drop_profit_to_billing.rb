class DropProfitToBilling < ActiveRecord::Migration[6.0]
  def change
    remove_column :billings, :cost
    remove_column :billings, :bill
    remove_column :billings, :profit
  end
end
