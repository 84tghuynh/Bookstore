class RemoveAuthorKeyFromBookAuthors < ActiveRecord::Migration[6.0]
  def change
    remove_column :book_authors, :author_key, :string
  end
end
