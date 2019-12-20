class Renametypetotypequotation < ActiveRecord::Migration[6.0]
  def change
    rename_column :quotations, :type, :type_quotation
  end
end
