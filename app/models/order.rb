class Order < ApplicationRecord
  belongs_to :customer

  has_many :book_items
  validates :pst, :gst, :hst, :order_date, presence: true
end
