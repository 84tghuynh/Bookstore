class CheckoutController < ApplicationController
  def index
    # unless session[:province_updated]
    #  session[:province_checkout_id] = current_customer.province_id if current_customer.present?
    # end

    @province = province_checkout

    # logger.debug("#########################: #{current_customer.email}")
  end

  # PUT/PATCH  /checkout/:id
  def update
    # update province_checkout
    logger.debug("#########################: selected: #{params[:selected]} , Id: #{params[:id]} Province_id: #{params[:province_id]} email: #{params[:email]} #########################")
    province_id = params[:province_id].to_i
    email = params[:email].to_s
    name = params[:name].to_s
    street_address = params[:street_address].to_s
    postalcode = params[:postalcode].to_s

    session[:province_checkout_id] = province_id

    session[:email]           = email
    session[:name]            = name
    session[:street_address]  = street_address
    session[:postalcode] = postalcode

    if params[:selected] == "none"
      # Update or Create Customer

    end

    redirect_to checkout_index_path
  end
end
