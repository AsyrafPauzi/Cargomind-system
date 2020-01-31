class AddQuotationIdToStatusUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_statuses, :quotation, foreign_key: true
  end
end
