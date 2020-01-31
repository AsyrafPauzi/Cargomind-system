class Insurance < ApplicationRecord
    mount_uploader :policy, FileUploader
    belongs_to :quotation
end
