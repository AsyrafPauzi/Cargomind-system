class Addweightstoquotations < ActiveRecord::Migration[6.0]
  def change
    add_column :quotations, :weight_fcl, :string
    add_column :quotations, :weight_air, :string
    rename_column :quotations, :weight, :weight_lcl
  end
end
