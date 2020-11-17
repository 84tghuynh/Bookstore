ActiveAdmin.register BookItem do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :book_id, :customer_id, :order_id, :price, :quantity
  permit_params :book_id, :customer_id, :order_id, :price, :quantity
  #
  # or
  #
  # permit_params do
  #   permitted = [:book_id, :customer_id, :order_id, :price, :quantity]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
