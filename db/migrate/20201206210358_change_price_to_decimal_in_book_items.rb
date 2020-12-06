class ChangePriceToDecimalInBookItems < ActiveRecord::Migration[6.0]
  def change
    change_column :book_items, :price, :decimal, precision: 12, scale: 2
  end
end
