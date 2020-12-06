class ChangeTaxToDecimalInOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :gst, :decimal, precision: 5, scale: 2
    change_column :orders, :pst, :decimal, precision: 5, scale: 2
    change_column :orders, :hst, :decimal, precision: 5, scale: 2
  end
end
