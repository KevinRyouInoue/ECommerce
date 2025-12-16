class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders, id: :bigint do |t|
      t.bigint :user_id, null: false
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.string :status, default: 'pending', null: false
      t.text :shipping_address, null: false

      t.timestamps
    end
    
    add_foreign_key :orders, :users
    add_index :orders, :user_id
  end
end
