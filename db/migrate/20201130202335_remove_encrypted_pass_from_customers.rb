class RemoveEncryptedPassFromCustomers < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :encrypted_pass, :string
  end
end
