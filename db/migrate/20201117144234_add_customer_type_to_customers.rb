class AddCustomerTypeToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :customer_type, :integer
  end
end
