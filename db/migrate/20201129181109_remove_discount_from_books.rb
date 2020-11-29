class RemoveDiscountFromBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :discount, :decimal, precision: 5, scale: 2
  end
end
