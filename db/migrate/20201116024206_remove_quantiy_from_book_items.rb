class RemoveQuantiyFromBookItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :book_items, :quantiy, :string
  end
end
