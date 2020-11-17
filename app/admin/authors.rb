ActiveAdmin.register Author do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :author_key, :name, :personal_name, :bio, :cover_s, :cover_m, :cover_l
  permit_params :author_key, :name, :personal_name, :bio, :image

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.inputs do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image, size: "200") : ""
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
