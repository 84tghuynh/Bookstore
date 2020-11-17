ActiveAdmin.register Book do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :isbn, :title, :description, :publisher, :publish_date, :number_of_pages, :book_url, :cover_s, :cover_m, :cover_l, :category_id
  permit_params :isbn, :title, :description, :publisher, :publish_date, :number_of_pages, :category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:isbn, :title, :description, :publisher, :publish_date, :number_of_pages, :book_url, :cover_s, :cover_m, :cover_l, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
