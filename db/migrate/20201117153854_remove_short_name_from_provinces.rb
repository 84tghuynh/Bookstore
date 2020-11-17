class RemoveShortNameFromProvinces < ActiveRecord::Migration[6.0]
  def change
    remove_column :provinces, :short_name, :string
  end
end
