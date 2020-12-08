class CheckoutController < ApplicationController
  # POST /checkout/create
  def create
    if cart.count == 0
      redirect_to root_path
      return
    end
    # Establish a connection with Stripe
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url,
      cancel_url:           checkout_success_url,
      line_items:           list_book_items_for_payment,
      customer_email:       session[:email]
    )

    # Perist data to Database
    persist_data if @session.present?

    respond_to do |format|
      format.js # Render app/view/checkout/create.js.erb
    end
  end

  def success
    @order = Order.find(session[:order_id])

    if @order.present?
      @order.update(
        stage_id: 2
      )
    end
    # Reset session
    session[:shopping_cart] = []
    session[:order_id] = -1


  end

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

  def persist_data
    # Customer Infomation in Session
    province_id = session[:province_checkout_id]
    email = session[:email]
    name = session[:name]
    street_address = session[:street_address]
    postalcode     = session[:postalcode]

    customer = Customer.where(email: email).first

    if customer.present?
      customer.update(
        province_id:    province_id,
        name:           name,
        street_address: street_address,
        postalcode:     postalcode
      )

      logger.debug("%%%%%%%%%%%%%%%%%%%%%%% UPDATE CUSTOMER: #{customer}, name: #{customer.name} =============================")
    else
      customer = Customer.new(name:           name,
                              province_id:    province_id,
                              email:          email,
                              street_address: street_address,
                              postalcode:     postalcode)

      customer.skip_password_validation = true
      customer.save

      customer.errors.full_messages.each do |message|
        logger.debug("%%%%%%Error: #{message}  %%%%%%%%%%%%%%%")
      end
    end

    # Create Order with Stage: new : 1
    order = Stage.find(1).orders.create(
      gst:         province_checkout.gst,
      pst:         province_checkout.pst,
      hst:         province_checkout.pst,
      customer_id: customer.id
    )

    session[:order_id] = order.id

    logger.debug("%%%%%%%%%%%%%%%%%%%%%%% Create ORDER: -outside #{order}, gst: #{order.gst} =============================")

    # Persist items in Cart into BookItems
    cart.map do |item|
      BookItem.create(
        book_id:     item[:book].id,
        customer_id: customer.id,
        price:       item[:book].price,
        sales:       item[:book].sales,
        quantity:    item[:quantity],
        order_id:    order.id
      )
    end
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
