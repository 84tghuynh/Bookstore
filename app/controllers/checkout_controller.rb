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
      create_customer(email, province_id, name, street_address, postalcode)
    end

    redirect_to checkout_index_path
  end

  def create_customer(email, province_id, name, street_address, postalcode)
    logger.debug("#########################: email: #{email}, name: #{name}, street_address: #{street_address}, postalcode: #{postalcode} #########################")
    @customer = Customer.where(email: email).first

    logger.debug("############ Query Customer: #{@customer}")

    if @customer.present?
      @customer.update(
        province_id:    province_id,
        name:           name,
        street_address: street_address,
        postalcode:     postalcode
      )
    else
      c = Customer.new(name:           name,
                       province_id:    province_id,
                       email:          email,
                       street_address: street_address,
                       postalcode:     postalcode)
      c.save

      o = Order.new(gst:         0.3,
                    pst:         0.4,
                    hst:         0.5,
                    customer_id: 106,
                    stage_id:    1)

      o.save

      logger.debug("############ Create Customer: #{o}, email: #{o.gst}")

    end
  end
end
