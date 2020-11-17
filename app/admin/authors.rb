ActiveAdmin.register Author do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :author_key, :name, :personal_name, :bio, :cover_s, :cover_m, :cover_l
  permit_params :author_key, :name, :personal_name, :bio
  #
  # or
  #
  # permit_params do
  #   permitted = [:author_key, :name, :personal_name, :bio, :cover_s, :cover_m, :cover_l]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
