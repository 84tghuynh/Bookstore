class CreateAbouts < ActiveRecord::Migration[6.0]
  def change
    create_table :abouts do |t|
      t.text :title
      t.text :content

      t.timestamps
    end
  end
end
