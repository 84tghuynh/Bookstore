class CreateBookAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :book_authors do |t|
      t.string :isbn
      t.string :author_key
      t.string :string
      t.references :book, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
