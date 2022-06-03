class Expense < ApplicationRecord
  validates :title, presence: true
  
  belongs_to :category
  has_one :user, through: :category

  monetize :amount_cents
end