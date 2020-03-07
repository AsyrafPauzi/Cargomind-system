# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_07_162421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "attach_pre_alerts", force: :cascade do |t|
    t.string "file_attach_pre_alert"
    t.string "remarks"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quotation_id"
    t.index ["quotation_id"], name: "index_attach_pre_alerts_on_quotation_id"
  end

  create_table "billing_details", force: :cascade do |t|
    t.string "title"
    t.bigint "billing_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "cost", precision: 9, scale: 2, default: "0.0"
    t.decimal "bill", precision: 9, scale: 2, default: "0.0"
    t.decimal "profit", precision: 9, scale: 2, default: "0.0"
    t.index ["billing_id"], name: "index_billing_details_on_billing_id"
  end

  create_table "billings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quotation_id"
    t.string "status"
    t.string "invoice"
    t.index ["quotation_id"], name: "index_billings_on_quotation_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "file_booking"
    t.string "booking_number"
    t.string "flight_number"
    t.string "vessel"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quotation_id"
    t.index ["quotation_id"], name: "index_bookings_on_quotation_id"
  end

  create_table "cargo_collections", force: :cascade do |t|
    t.string "file_rot"
    t.string "estimated_collection_date"
    t.string "truck_number"
    t.string "driver_name"
    t.string "driver_phone_number"
    t.string "truck_type"
    t.string "status"
    t.string "haulage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quotation_id"
    t.string "lcl_remarks"
    t.index ["quotation_id"], name: "index_cargo_collections_on_quotation_id"
  end

  create_table "cargo_declarations", force: :cascade do |t|
    t.string "file_declaration"
    t.string "remarks"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quotation_id"
    t.string "file_client_draft"
    t.index ["quotation_id"], name: "index_cargo_declarations_on_quotation_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "no_tel"
    t.text "address"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "company"
    t.text "address"
    t.string "no_tel"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "client_id"
    t.index ["client_id"], name: "index_customers_on_client_id"
  end

  create_table "insurances", force: :cascade do |t|
    t.string "status"
    t.bigint "quotation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "policy"
    t.index ["quotation_id"], name: "index_insurances_on_quotation_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.string "quotation_id"
    t.string "type_quotation"
    t.date "date"
    t.text "shipper"
    t.text "consignee"
    t.string "port_of_loading"
    t.string "port_of_discharge"
    t.string "final_destination"
    t.string "mode_of_shipment"
    t.string "weight_type"
    t.text "weight_lcl"
    t.string "commodity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "weight_fcl"
    t.string "weight_air"
    t.string "status"
    t.string "isamendment"
    t.bigint "client_id"
    t.bigint "user_id"
    t.string "quotation_status"
    t.string "file_quotation"
    t.string "remarks"
    t.string "file_client"
    t.index ["client_id"], name: "index_quotations_on_client_id"
    t.index ["user_id"], name: "index_quotations_on_user_id"
  end

  create_table "slbl_confirmations", force: :cascade do |t|
    t.string "file_confirmation"
    t.string "remarks"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quotation_id"
    t.string "file_client_draft"
    t.string "notify_party"
    t.string "delivery_agent"
    t.string "voyage_no"
    t.string "combined_transport_onward_carriage"
    t.string "place_of_receipt"
    t.string "freight_payable_at"
    t.string "place_of_delivery"
    t.string "sibl_no"
    t.string "marks_and_numbers"
    t.string "no_of_pkgs"
    t.string "description_of_goods"
    t.string "gross_weight"
    t.string "measurement"
    t.string "container_no"
    t.string "seal_no"
    t.string "number_of_packages_in_words"
    t.string "place_issue"
    t.string "date_issue"
    t.string "date"
    t.string "by"
    t.index ["quotation_id"], name: "index_slbl_confirmations_on_quotation_id"
  end

  create_table "user_statuses", force: :cascade do |t|
    t.string "description"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "quotation_id"
    t.index ["quotation_id"], name: "index_user_statuses_on_quotation_id"
    t.index ["user_id"], name: "index_user_statuses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "no_tel"
    t.string "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vessel_departs", force: :cascade do |t|
    t.string "status"
    t.bigint "quotation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quotation_id"], name: "index_vessel_departs_on_quotation_id"
  end

  add_foreign_key "attach_pre_alerts", "quotations"
  add_foreign_key "billing_details", "billings"
  add_foreign_key "billings", "quotations"
  add_foreign_key "bookings", "quotations"
  add_foreign_key "cargo_collections", "quotations"
  add_foreign_key "cargo_declarations", "quotations"
  add_foreign_key "customers", "clients"
  add_foreign_key "insurances", "quotations"
  add_foreign_key "quotations", "clients"
  add_foreign_key "quotations", "users"
  add_foreign_key "slbl_confirmations", "quotations"
  add_foreign_key "user_statuses", "quotations"
  add_foreign_key "user_statuses", "users"
  add_foreign_key "vessel_departs", "quotations"
end
