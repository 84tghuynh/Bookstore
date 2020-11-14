class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :author_key
      t.string :name
      t.string :personal_name
      t.text :bio
      t.text :cover_s
      t.text :cover_m
      t.text :cover_l

      t.timestamps
    end
  end
end
