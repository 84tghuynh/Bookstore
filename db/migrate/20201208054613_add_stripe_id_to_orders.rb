class AddStripeIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :stripe_id, :string
  end
end
