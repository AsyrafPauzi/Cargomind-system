class CreateSlblConfirmation < ActiveRecord::Migration[6.0]
  def change
    create_table :slbl_confirmations do |t|
      t.string  :file_confirmation
      t.string  :remarks
      t.string  :status
      t.timestamps
      t.references :quotation, foreign_key: true
    end
  end
end
