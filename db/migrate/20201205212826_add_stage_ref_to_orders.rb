class AddStageRefToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :stage, null: false, foreign_key: true
  end
end
