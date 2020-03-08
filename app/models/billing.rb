class Billing < ApplicationRecord
    mount_uploader :invoice, FileUploader
    belongs_to :quotation
    has_many :billing_details, dependent: :delete_all
    serialize :cost
    serialize :bill
    serialize :profit
end
