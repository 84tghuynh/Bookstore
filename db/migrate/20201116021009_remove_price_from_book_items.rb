class RemovePriceFromBookItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :book_items, :price, :string
  end
end
