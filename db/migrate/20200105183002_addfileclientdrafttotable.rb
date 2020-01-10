class Addfileclientdrafttotable < ActiveRecord::Migration[6.0]
  def change
    add_column :cargo_declarations, :file_client_draft, :string
    add_column :slbl_confirmations, :file_client_draft, :string
  end
end
