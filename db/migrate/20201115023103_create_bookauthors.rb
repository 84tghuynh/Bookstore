class CreateBookauthors < ActiveRecord::Migration[6.0]
  def change
    create_table :bookauthors do |t|
      t.string :isbn
      t.string :author_key
      t.references :book, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
