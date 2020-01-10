class CargoCollection < ApplicationRecord
    mount_uploader :file_rot, FileUploader
    belongs_to :quotation


  end
  