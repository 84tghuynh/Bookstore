class Province < ApplicationRecord
  has_many :customers
  validates :name, :pst, :gst, :hst, presence: true
  validates :name, uniqueness: true
end
