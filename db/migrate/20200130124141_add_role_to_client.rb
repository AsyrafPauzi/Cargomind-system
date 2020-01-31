class AddRoleToClient < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :role, :string
  end
end
