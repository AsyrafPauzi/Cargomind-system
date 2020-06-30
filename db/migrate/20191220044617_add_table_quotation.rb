class AddTableQuotation < ActiveRecord::Migration[6.0]
  def change
    create_table :quotations do |t|
      t.string  :quotation_code
      t.string  :type
      t.date  :date
      t.string  :attn
      t.string  :booking_no
      t.text  :shipper
      t.text :consignee
      t.string  :port_of_loading
      t.string  :port_of_discharge
      t.string  :final_destination
      t.string :cargo_type
      t.string :weight_type
      t.text :weight
      t.string :commodity 
      t.timestamps
      t.references :user, foreign_key: true
    end
  end
end
