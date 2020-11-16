class RemoveQuantityFromBookItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :book_items, :quantity, :string
  end
end
