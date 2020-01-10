class AttachPreAlert < ApplicationRecord
    mount_uploader :file_attach_pre_alert, FileUploader
    belongs_to :quotation


  end
  