class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :transaction
      t.float :total
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :payment, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.references :shipping, null: false, foreign_key: true

      t.timestamps
    end
  end
end
