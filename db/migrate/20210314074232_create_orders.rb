class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :order_status
      t.integer :total_price
      t.integer :postcode
      t.string :address
      t.integer :payment_selection, default: 0
      t.integer :postage
      t.string :address_name

      t.timestamps
    end
  end
end
