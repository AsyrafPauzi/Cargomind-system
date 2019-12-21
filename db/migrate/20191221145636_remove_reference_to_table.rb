class RemoveReferenceToTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :quotations, :client_id
    add_reference :quotations, :client, foreign_key: true
  end
end
