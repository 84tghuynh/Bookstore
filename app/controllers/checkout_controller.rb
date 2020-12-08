class CheckoutController < ApplicationController
  # POST /checkout/create
  def create
    # Establish a connection with Stripe
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url,
      cancel_url:           checkout_success_url,
      line_items:           list_book_items_for_payment
    )

    respond_to do |format|
      format.js # Render app/view/checkout/create.js.erb
    end
  end

  def success; end

  def cancel; end

  def index
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

    if params[:selected] == "province"
      session[:province_checkout_id] = province_id

      session[:email]           = email
      session[:name]            = name
      session[:street_address]  = street_address
      session[:postalcode] = postalcode

    end

    if params[:selected] == "none"
      # Update or Create Customer
      # create_customer(email, province_id, name, street_address, postalcode)
      session[:province_checkout_id] = province_id

      session[:email] = email
      session[:name]            = name
      session[:street_address]  = street_address
      session[:postalcode] = postalcode

      # Stage Checkout
      # 1: Filling Shipping Information
      # 2: Shipping Information and preparing submit payment
      session[:stage] = 2
    elsif params[:selected] == "edit"
      # Stage Checkout
      # 1: Filling Shipping Information
      # 2: Shipping Information and preparing submit payment
      session[:stage] = 1
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

      logger.debug("%%%%%%%%%%%%%%%%%%%%%%% UPDATE CUSTOMER: #{@customer}, name: #{@customer.name} =============================")
    else
      c = Customer.new(name:           name,
                       province_id:    province_id,
                       email:          email,
                       street_address: street_address,
                       postalcode:     postalcode)

      c.skip_password_validation = true
      c.save

      c.errors.full_messages.each do |message|
        logger.debug("%%%%%%Error: #{message}  %%%%%%%%%%%%%%%")
      end

      o = Order.new(gst:         0.3,
                    pst:         0.4,
                    hst:         0.5,
                    customer_id: 106,
                    stage_id:    1)

      o.save
      logger.debug("%%%%%%%%%%%%%%%%%%%%%%% ELSE Create Order: #{o}, name: #{o.gst} =============================")
    end

    o = Stage.find(1).orders.create(gst:         0.3,
                                    pst:         0.4,
                                    hst:         0.5,
                                    customer_id: 106)

    logger.debug("%%%%%%%%%%%%%%%%%%%%%%% Create ORDER: -outside #{o}, gst: #{o.gst} =============================")
  end
end
