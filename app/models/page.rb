class Page < ApplicationRecord
  validates :title, :content, :page_type, presence: true
  has_one_attached :image
end
