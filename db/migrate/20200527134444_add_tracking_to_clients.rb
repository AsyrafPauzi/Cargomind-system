class AddTrackingToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :current_sign_in_ip, :string
    add_column :clients, :last_sign_in_ip, :string
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_ip, :string
 end
end
