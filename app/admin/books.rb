ActiveAdmin.register Book do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :isbn, :title, :description, :publisher, :publish_date, :number_of_pages, :book_url, :cover_s, :cover_m, :cover_l, :category_id
  permit_params :isbn, :title, :price, :description, :publisher, :publish_date, :number_of_pages, :book_url, :cover_s, :cover_m, :cover_l, :category_id, :image

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.inputs do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image, size: "200") : ""
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
