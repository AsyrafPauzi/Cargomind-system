class Addisamendmenttotable < ActiveRecord::Migration[6.0]
  def change
    add_column :quotations, :isamendment, :string
  end
end
