class CreateBillingDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :billing_details do |t|
      t.string  :title
      t.decimal :bill, :precision => 8, :scale => 2
      t.decimal :cost, :precision => 8, :scale => 2
      t.decimal :profit, :precision => 8, :scale => 2
      t.references :billing, foreign_key: true
      t.timestamps
      
    end
  end
end
