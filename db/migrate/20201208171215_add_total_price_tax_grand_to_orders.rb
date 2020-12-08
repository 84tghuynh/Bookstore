class AddTotalPriceTaxGrandToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :total_price, :decimal, precision: 12, scale: 2
    add_column :orders, :total_tax, :decimal, precision: 12, scale: 2
    add_column :orders, :grand_total, :decimal, precision: 12, scale: 2
  end
end
