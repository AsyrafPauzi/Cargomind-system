class CreateCargoDeclaration < ActiveRecord::Migration[6.0]
  def change
    create_table :cargo_declarations do |t|
      t.string  :file_declaration
      t.string  :remarks
      t.string  :status
      t.timestamps
      t.references :quotation, foreign_key: true
    end
  end
end
