  class Quotation < ApplicationRecord
    validates :date, presence: true
    before_create :generate_random_id
    belongs_to :user


    private 
    def generate_random_id
    self.quotation_id = SecureRandom.hex(5)
    end 
  end
  