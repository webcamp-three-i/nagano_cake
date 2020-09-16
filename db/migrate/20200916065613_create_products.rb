class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :genre_id
      t.string :name
      t.string :image_id
      t.text :description
      t.integer :price_without_tax
      t.boolean :sales_status, default: true

      t.timestamps
    end
  end
end
