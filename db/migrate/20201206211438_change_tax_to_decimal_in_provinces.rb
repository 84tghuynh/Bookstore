class ChangeTaxToDecimalInProvinces < ActiveRecord::Migration[6.0]
  def change
    change_column :provinces, :gst, :decimal, precision: 5, scale: 2
    change_column :provinces, :pst, :decimal, precision: 5, scale: 2
    change_column :provinces, :hst, :decimal, precision: 5, scale: 2
  end
end
