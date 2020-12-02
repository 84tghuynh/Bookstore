class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_session
  helper_method :cart

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
    existing_item = session[:shopping_cart].map { |item| item["id"] }
    Book.find(existing_item)
  end
end
