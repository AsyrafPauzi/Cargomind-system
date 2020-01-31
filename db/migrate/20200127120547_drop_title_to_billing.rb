class DropTitleToBilling < ActiveRecord::Migration[6.0]
  def change
    remove_column :billings, :title
    add_column :billings, :title, :string
  end
end
