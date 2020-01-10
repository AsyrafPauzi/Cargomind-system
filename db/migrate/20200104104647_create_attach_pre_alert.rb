class CreateAttachPreAlert < ActiveRecord::Migration[6.0]
  def change
    create_table :attach_pre_alerts do |t|
      t.string  :file_attach_pre_alert
      t.string  :remarks
      t.string  :status
      t.timestamps
      t.references :quotation, foreign_key: true
    end
  end
end
