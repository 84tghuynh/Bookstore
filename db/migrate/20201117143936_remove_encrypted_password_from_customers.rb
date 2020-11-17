class RemoveEncryptedPasswordFromCustomers < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :encrypted_password, :string
  end
end
