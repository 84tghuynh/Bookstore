class CartController < ApplicationController
  # Listing Items in Cart
  def index; end

  # POST /cart
  # Data sent as form data (params)
  def create
    # Add params[:id] to cart
    # logger.debug("Adding #{params[:id]} to the cart----------------------------------------")
    id = params[:id].to_i

    existing_item = session[:shopping_cart].map { |item| item["id"] }

    unless existing_item.include?(id)
      item = { id: id, quantity: 1 }
      session[:shopping_cart] << item

    end
    redirect_to root_path
  end

  # DELETE /cart/:id
  def destroy
    # Remove params[:id] from the cart
    # logger.debug("Adding #{params[:in_cart_detail]} to the cart-#########################")
    id = params[:id].to_i
    session[:shopping_cart].delete_if { |item| item["id"] == id }

    if params[:in_cart_detail].present?
      redirect_to cart_index_path
    else
      redirect_to root_path
    end
  end

  # PUT/PATCH  /cart/:id
  def update
    # update quanity
    logger.debug("change #{params[:id]} quantity #{params[:quantity]} to the cart-#########################")
    id = params[:id].to_i
    quantity = params[:quantity].to_i

    item = session[:shopping_cart].find { |hash| hash["id"] == id }
    item["quantity"] = quantity

    redirect_to cart_index_path
  end
end
