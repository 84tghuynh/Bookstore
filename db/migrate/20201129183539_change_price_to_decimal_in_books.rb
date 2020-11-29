class ChangePriceToDecimalInBooks < ActiveRecord::Migration[6.0]
  def change
    # change_column :table_name, :column_name, :new_type
    change_column :books, :price, :decimal, precision: 12, scale: 2
  end
end
