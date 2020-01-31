  class Quotation < ApplicationRecord
    mount_uploader :file_quotation, FileUploader
    mount_uploader :file_client, FileUploader
    before_create :generate_random_id
    belongs_to :client
    belongs_to :user, optional: true
    has_one :attach_pre_alert, :dependent => :delete
    has_one :booking, :dependent => :delete
    has_one :cargo_declaration, :dependent => :delete
    has_one :cargo_collection, :dependent => :delete
    has_one :slbl_confirmation, :dependent => :delete
    has_one :insurance, :dependent => :delete
    has_one :vessel_depart, :dependent => :delete
    has_one :billing, :dependent => :delete
    has_many :user_statuses



    private 
    def generate_random_id
    self.quotation_id = SecureRandom.hex(5)
    end 
  end
  