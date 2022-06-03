class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, 
                    uniqueness: {  message: " is invalid" }, 
                    format: %r{\A.+@.+\Z}
  validates :password, length: { minimum: 8, max: 128 }

  has_many :categories
  monetize :available_cents
end