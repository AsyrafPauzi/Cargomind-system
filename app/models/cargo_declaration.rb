class CargoDeclaration < ApplicationRecord
    mount_uploader :file_declaration, FileUploader
    mount_uploader :file_client_draft, FileUploader
    belongs_to :quotation
    

  end
  