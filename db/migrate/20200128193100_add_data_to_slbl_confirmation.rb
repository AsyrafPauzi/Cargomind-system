class AddDataToSlblConfirmation < ActiveRecord::Migration[6.0]
  def change
    add_column :slbl_confirmations, :notify_party, :string
    add_column :slbl_confirmations, :delivery_agent, :string
    add_column :slbl_confirmations, :voyage_no, :string
    add_column :slbl_confirmations, :combined_transport_onward_carriage, :string
    add_column :slbl_confirmations, :place_of_receipt, :string
    add_column :slbl_confirmations, :freight_payable_at, :string
    add_column :slbl_confirmations, :place_of_delivery, :string
    add_column :slbl_confirmations, :sibl_no, :string
    add_column :slbl_confirmations, :marks_and_numbers, :string
    add_column :slbl_confirmations, :no_of_pkgs, :string
    add_column :slbl_confirmations, :description_of_goods, :string
    add_column :slbl_confirmations, :gross_weight, :string
    add_column :slbl_confirmations, :measurement, :string
    add_column :slbl_confirmations, :container_no, :string
    add_column :slbl_confirmations, :seal_no, :string
    add_column :slbl_confirmations, :number_of_packages_in_words, :string
    add_column :slbl_confirmations, :place_issue, :string
    add_column :slbl_confirmations, :date_issue, :string
    add_column :slbl_confirmations, :date, :string
    add_column :slbl_confirmations, :by, :string
  end
end