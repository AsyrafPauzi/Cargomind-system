class Booking < ApplicationRecord
    mount_uploader :file_booking, FileUploader
    belongs_to :quotation


  end
  