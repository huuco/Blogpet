class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.float :sub_total
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
