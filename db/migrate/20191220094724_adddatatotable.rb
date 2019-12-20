class Adddatatotable < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :address, :text
    add_column :users, :no_tel, :string
    add_column :users, :name, :string
  end
end
