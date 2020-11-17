class BookAuthor < ApplicationRecord
  belongs_to :book
  belongs_to :author

  #validates :isbn, :author_key, presence: true
  validates_associated :book
  validates_associated :author
end
