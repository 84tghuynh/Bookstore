class RemoveStringFromBookAuthors < ActiveRecord::Migration[6.0]
  def change
    remove_column :book_authors, :string, :string
  end
end
