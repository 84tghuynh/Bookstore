class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_session
  helper_method :cart
  helper_method :list_book_items
  helper_method :items_quantity

  protected

  def configure_permitted_parameters
    added_attrs = %i[province_id name street_address postalcode]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  private

  def initialize_session
    # this will be where we initialize our shopping cart
    session[:shopping_cart] ||= []
  end

  def cart
    # Return a collection of Book objects based on the books ids in the shopping cart
    # existing_item = session[:shopping_cart].map { |item| item["id"] }
    # books = Book.find(existing_item)

    list_item = []

    session[:shopping_cart].map do |item|
      @book = Book.find(item["id"])
      book_item = { book: @book, quantity: item["quantity"] }
      list_item << book_item
    end
    list_item
  end

  def list_book_items
    existing_item = session[:shopping_cart].map { |item| item["id"] }
    Book.find(existing_item)
  end

  def items_quantity
    quantity = 0
    session[:shopping_cart].map do |item|
      quantity += item["quantity"]
    end
    quantity
  end
end
