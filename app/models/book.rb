class Book < ApplicationRecord
  belongs_to :category

  has_many :book_authors
  has_many :authors, through: :book_authors

  has_many :book_items
  has_many :customers, through: :book_items

  validates :isbn, :title, presence: true
  validates :isbn, uniqueness: true
  validates :number_of_pages, numericality: { only_integer: true }, allow_nil: true
end
