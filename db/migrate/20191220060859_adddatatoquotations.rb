class Adddatatoquotations < ActiveRecord::Migration[6.0]
  def change
    add_column :quotations, :to, :string
  end
end
