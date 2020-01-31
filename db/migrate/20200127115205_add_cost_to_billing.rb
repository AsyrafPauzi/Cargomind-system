class AddCostToBilling < ActiveRecord::Migration[6.0]
  def change
    add_column :billings, :invoice, :string
    add_column :billings, :title, :string, :precision => 8, :scale => 2
    add_column :billings, :cost, :decimal, :precision => 8, :scale => 2
    add_column :billings, :bill, :decimal, :precision => 8, :scale => 2
    add_column :billings, :profit, :decimal, :precision => 8, :scale => 2
    add_column :insurances, :policy, :string
  end
end
