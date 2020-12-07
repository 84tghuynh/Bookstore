class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :stage

  has_many :book_items
  validates :pst, :gst, :hst, presence: true
end
