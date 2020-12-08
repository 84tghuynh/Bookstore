ActiveAdmin.register Customer do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :email, :encrypted_password, :customer_type, :street_address, :postalcode, :latitude, :longitude, :province_id

  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :password, :type, :street_address, :country, :postalcode, :latitude, :longitude, :province_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # sidebar "Orders Details", only: %i[show edit] do
  #  ul do
  #    li link_to "Orders", admin_customer_orders_path(resource)
  #  end
  # end
  show do
    panel "Customer Details" do
      attributes_table_for customer do
        row :id
        row :email
        row :name
        row :street_address
        row :postalcode
        row :province
      end
      panel "Orders" do
        table_for customer.orders do
          column :id
          column :gst
          column :pst
          column :hst
          column :stage
          column "Book_items" do |order|
            table_for order.book_items do
              column :book
              column :price
              column :quantity
            end
          end
        end
      end
    end
  end
end
