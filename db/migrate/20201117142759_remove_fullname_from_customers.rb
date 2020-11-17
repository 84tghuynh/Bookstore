class RemoveFullnameFromCustomers < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :fullname, :string
  end
end
