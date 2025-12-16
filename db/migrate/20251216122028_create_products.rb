class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products, id: :bigint do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :stock_quantity, default: 0, null: false
      t.string :image_url
      t.bigint :category_id, null: false

      t.timestamps
    end
    
    add_foreign_key :products, :categories
  end
end
