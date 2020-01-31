class DropTitle < ActiveRecord::Migration[6.0]
  def change
    remove_column :billings, :title
  end
end
