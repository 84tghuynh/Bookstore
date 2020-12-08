class Customer < ApplicationRecord
  attr_accessor :skip_password_validation  # virtual attribute to skip password validation while saving
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province
  has_many :orders

  has_many :book_items
  has_many :books, through: :book_items
  validates :email, :province, presence: true
  validates :email, uniqueness: true

  protected

  def password_required?
    return false if skip_password_validation

    super
  end
end
