class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.text :title
      t.text :content
      t.string :page_type

      t.timestamps
    end
  end
end
