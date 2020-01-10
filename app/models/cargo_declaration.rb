class CargoDeclaration < ApplicationRecord
    mount_uploader :file_draft, FileUploader
    mount_uploader :file_client_draft, FileUploader
    belongs_to :quotation
    

  end
  