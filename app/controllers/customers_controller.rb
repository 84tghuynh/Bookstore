class CustomersController < ApplicationController
  def show
    # current_customer.id
    @orders = Customer.find(current_customer.id.to_i).orders.all
  end
end
