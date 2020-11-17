class AddFullnameToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :fullname, :string
  end
end
