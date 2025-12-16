class CreateOrderItems < ActiveRecord::Migration[8.1]
  def change
    create_table :order_items, id: :bigint do |t|
      t.bigint :order_id, null: false
      t.bigint :product_id, null: false
      t.integer :quantity, null: false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end
    
    add_foreign_key :order_items, :orders
    add_foreign_key :order_items, :products
    add_index :order_items, :order_id
    add_index :order_items, :product_id
  end
end
