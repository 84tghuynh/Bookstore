class AddQuantityToBookItems < ActiveRecord::Migration[6.0]
  def change
    add_column :book_items, :quantity, :integer
  end
end
