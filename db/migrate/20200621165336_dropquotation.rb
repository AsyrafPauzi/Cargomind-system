class Dropquotation < ActiveRecord::Migration[6.0]
  def change
    remove_column :quotations, :quotation_code
    remove_column :quotations, :type_quotation
    remove_column :quotations, :date
    remove_column :quotations, :shipper
    remove_column :quotations, :consignee
    remove_column :quotations, :port_of_loading
    remove_column :quotations, :port_of_discharge
    remove_column :quotations, :final_destination
    remove_column :quotations, :mode_of_shipment
    remove_column :quotations, :weight_type
    remove_column :quotations, :weight_lcl
    remove_column :quotations, :commodity
    remove_column :quotations, :weight_fcl
    remove_column :quotations, :weight_air
    remove_column :quotations, :status
    remove_column :quotations, :isamendment
    remove_column :quotations, :quotation_status
    remove_column :quotations, :file_quotation
    remove_column :quotations, :remarks
    remove_column :quotations, :file_client

    add_column :quotations, :quotation_code, :string
    add_column :quotations, :remarks, :string

    add_column :quotations, :mode_of_shipment, :string
    add_column :quotations, :mode_of_transport, :string
    add_column :quotations, :incoterm, :string
    add_column :quotations, :currency, :string

    add_column :quotations, :collection_company_name, :string
    add_column :quotations, :collection_address, :string
    add_column :quotations, :collection_pic, :string
    add_column :quotations, :collection_no_tel, :string

    add_column :quotations, :port_of_loading_port, :string
    add_column :quotations, :port_of_loading_state, :string
    add_column :quotations, :port_of_loading_country, :string

    add_column :quotations, :port_of_destination_port, :string
    add_column :quotations, :port_of_destination_state, :string
    add_column :quotations, :port_of_destination_country, :string

    add_column :quotations, :deliver_company_name, :string
    add_column :quotations, :deliver_address, :string
    add_column :quotations, :deliver_pic, :string
    add_column :quotations, :deliver_no_tel, :string

    add_column :quotations, :cargo_type, :string
    add_column :quotations, :cargo_type_msds, :string
    add_column :quotations, :cargo_type_commodity, :string

    add_column :quotations, :cargo_details, :string
    add_column :quotations, :cargo_details_fcl_data, :string
    add_column :quotations, :cargo_details_lcl_data, :string

    add_column :quotations, :others_warehouse, :string
    add_column :quotations, :others_insurance, :string
    add_column :quotations, :others_cargo_value, :string
  end
end
