class CreateCartItems < ActiveRecord::Migration[8.1]
  def change
    create_table :cart_items, id: :bigint do |t|
      t.bigint :product_id, null: false
      t.integer :quantity, null: false, default: 1
      t.string :session_id
      t.bigint :user_id, null: true

      t.timestamps
    end
    
    add_foreign_key :cart_items, :products
    add_foreign_key :cart_items, :users
    add_index :cart_items, :product_id
    add_index :cart_items, :user_id
  end
end
