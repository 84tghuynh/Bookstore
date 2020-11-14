class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.text :description
      t.string :publisher
      t.string :publish_date
      t.integer :number_of_pages
      t.text :book_url
      t.text :cover_s
      t.text :cover_m
      t.text :cover_l
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
