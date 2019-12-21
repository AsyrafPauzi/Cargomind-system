class AddTableCustomerTable < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string  :name
      t.string  :company
      t.text  :address
      t.string  :no_tel
      t.timestamps
      t.references :client, foreign_key: true
    end
  end
end
