class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :url
      t.references :link

      t.timestamps
    end
    add_index :products, :link_id
  end
end
