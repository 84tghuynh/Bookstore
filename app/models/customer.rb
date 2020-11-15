class Customer < ApplicationRecord
  belongs_to :province

  has_many :book_items
  has_many :books, through: :book_items
  validates :name, :street_address, :province, presence: true
  validates :name, :street_address, uniqueness: true
end
