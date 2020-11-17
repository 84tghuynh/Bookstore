class AddEncryptedPasswordToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :encrypted_password, :string
  end
end
