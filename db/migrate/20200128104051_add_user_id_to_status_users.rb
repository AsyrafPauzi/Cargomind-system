class AddUserIdToStatusUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_statuses, :user, foreign_key: true
  end
end
