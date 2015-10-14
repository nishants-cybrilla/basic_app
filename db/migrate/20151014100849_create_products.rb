class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :image
      t.text :product_url
      t.references :store, index: true

      t.timestamps null: false
    end
  end
end
