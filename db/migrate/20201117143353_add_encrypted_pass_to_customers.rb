class AddEncryptedPassToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :encrypted_pass, :string
  end
end
