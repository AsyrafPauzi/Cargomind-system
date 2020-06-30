  class Quotation < ApplicationRecord
    mount_uploader :cargo_type_msds, FileUploader
    before_create :generate_random_id
    belongs_to :client
    serialize :cargo_details_fcl_data, Array



    private 
    def generate_random_id
    self.quotation_code = SecureRandom.hex(5)
    end

  end
  