class AddPriceToBookItems < ActiveRecord::Migration[6.0]
  def change
    add_column :book_items, :price, :float
  end
end
