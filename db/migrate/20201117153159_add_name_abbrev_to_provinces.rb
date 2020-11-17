class AddNameAbbrevToProvinces < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :name_abbrev, :string
  end
end
