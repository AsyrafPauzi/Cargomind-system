class SlblConfirmation < ApplicationRecord
    mount_uploader :file_confirmation, FileUploader
    mount_uploader :file_client_draft, FileUploader
    belongs_to :quotation


  end
  
