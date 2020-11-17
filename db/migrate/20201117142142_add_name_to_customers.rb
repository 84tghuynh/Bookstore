class AddNameToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :name, :string
  end
end
