class BookItem < ApplicationRecord
  belongs_to :book
  belongs_to :customer
  belongs_to :order

  validates :price, :quantiy, presence: true
  validates_associated :book
  validates_associated :customer
end
