class AddShortNameToProvinces < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :short_name, :string
  end
end
