class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :province

  has_many :book_items
  has_many :books, through: :book_items
  validates :email, :province, presence: true
  validates :email, uniqueness: true
end
