class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.float :pst
      t.float :gst
      t.float :hst
      t.datetime :order_date
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
