class UserStatus < ApplicationRecord
    belongs_to :user
    belongs_to :quotation
end
