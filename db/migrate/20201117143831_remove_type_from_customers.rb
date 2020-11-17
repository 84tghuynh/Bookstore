class RemoveTypeFromCustomers < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :type, :integer
  end
end
