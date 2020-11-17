class RemovePaswordFromCustomers < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :password, :string
  end
end
