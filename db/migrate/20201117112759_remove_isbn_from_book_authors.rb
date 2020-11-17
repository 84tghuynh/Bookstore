class RemoveIsbnFromBookAuthors < ActiveRecord::Migration[6.0]
  def change
    remove_column :book_authors, :isbn, :string
  end
end
