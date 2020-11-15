class BookItem < ApplicationRecord
  belongs_to :book
  belongs_to :customer
  belongs_to :order
end
