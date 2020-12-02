class CartController < ApplicationController
  # POST /cart
  # Data sent as form data (params)
  def create
    # Add params[:id] to cart
    logger.debug("Adding #{params[:id]} to the cart----------------------------------------")
    id = params[:id].to_i

    existing_item = session[:shopping_cart].map { |item| item["id"] }

    unless existing_item.include?(id)
      item = { id: id, quantity: 5 }
      session[:shopping_cart] << item
    end

    redirect_to root_path
  end

  # DELETE /cart/:id
  def destroy
    # Remove params[:id] from the cart
    id = params[:id].to_i

    session[:shopping_cart].delete_if { |item| item["id"] == id }

    logger.debug("Remove #{params[:id]} from the cart---------------------------------------")
    # book = Book.find(id)

    redirect_to root_path
  end
end
