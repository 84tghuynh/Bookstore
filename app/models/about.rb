class About < ApplicationRecord
  validates :title, :content, presence: true
  has_one_attached :image
end
