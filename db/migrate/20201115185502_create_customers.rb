class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :email
      t.string :password
      t.integer :type
      t.string :street_address
      t.string :country
      t.string :postalcode
      t.string :latitude
      t.string :longitude
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
