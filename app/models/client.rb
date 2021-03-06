class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, 
  :confirmable
  
  has_many :quotations, dependent: :delete_all
  has_many :customers, dependent: :delete_all
end
