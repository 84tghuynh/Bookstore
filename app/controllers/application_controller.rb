class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_session
  helper_method :cart
  helper_method :list_book_items
  helper_method :items_quantity, :total_price, :total_price_with_tax, :province_checkout, :customer_checkout

  protected

  def configure_permitted_parameters
    added_attrs = %i[province_id name street_address postalcode]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  def after_sign_in_path_for(resource)
    # session[:province_updated] = false
    session[:province_checkout_id] = (current_customer.province_id if current_customer.present?)
    root_path
  end

  private

  def initialize_session
    # this will be where we initialize our shopping cart
    session[:shopping_cart] ||= []

    session[:province_checkout_id] ||= if current_customer.present?
                                         current_customer.province_id
                                       else
                                         Province.all.first.id
                                       end

    session[:email]          ||= ""
    session[:name]           ||= ""
    session[:street_address] ||= ""
    session[:postalcode] ||= ""

    # Stage Checkout
    # 1: Filling Shipping Information
    # 2: Shipping Information and preparing submit payment
    session[:stage] ||= 1
    # Not Used
    session[:province_updated] ||= false

    # Not Used
    session[:customer_checkout_email] ||= if current_customer.present?
                                            current_customer.email.to_s
                                          else
                                            ""
                                          end
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

  def total_price
    total = 0
    session[:shopping_cart].map do |item|
      @book = Book.find(item["id"])

      total = if @book.sales > 0.0099
                total + item["quantity"] * @book.price * (1 - @book.sales)
              else
                total + item["quantity"] * @book.price
              end
    end
    total
  end

  def province_checkout
    Province.find(session[:province_checkout_id].to_i)
  end

  # Not used
  def customer_checkout
    Customer.all.where("email = ? ", session[:customer_checkout_email].to_s).limit(1).first
  end

  def total_price_with_tax
    total = 0
    total = total_price + total_price * (province_checkout.pst + province_checkout.gst + province_checkout.hst)
  end
end
