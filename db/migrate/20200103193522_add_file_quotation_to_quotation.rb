class AddFileQuotationToQuotation < ActiveRecord::Migration[6.0]
  def change
    add_column :quotations, :file_quotation, :string
  end
end
