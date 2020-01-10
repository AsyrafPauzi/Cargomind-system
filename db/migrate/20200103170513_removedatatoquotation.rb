class Removedatatoquotation < ActiveRecord::Migration[6.0]
  def change
    remove_column :quotations, :attn
    remove_column :quotations, :booking_no
    remove_column :quotations, :to
  end
end
