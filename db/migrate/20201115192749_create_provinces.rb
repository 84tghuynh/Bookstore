class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.float :pst
      t.float :gst
      t.float :hst

      t.timestamps
    end
  end
end
