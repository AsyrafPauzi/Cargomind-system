class Addusersidtoquotation < ActiveRecord::Migration[6.0]
  def change
    add_reference :quotations, :user, foreign_key: true
    add_column :quotations, :quotation_status, :string
  end
end
