class AddSalesToBookItems < ActiveRecord::Migration[6.0]
  def change
    add_column :book_items, :sales, :decimal, precision: 5, scale: 2, default: 0
  end
end
