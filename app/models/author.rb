class Author < ApplicationRecord
  has_many :book_authors
  has_many :books, through: :book_authors
  validates :author_key, :name, presence: true
  validates :author_key, uniqueness: true
end
