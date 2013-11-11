class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :phrase
      t.string :page_url
      t.string :image_url
      t.string :category
      t.string :product_url
      t.text :description
      t.references :site

      t.timestamps
    end
    add_index :links, :site_id
  end
end
