class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, limit: 256
      t.float :price, null: false
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end
  end
end
