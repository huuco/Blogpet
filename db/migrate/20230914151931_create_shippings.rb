class CreateShippings < ActiveRecord::Migration[7.0]
  def change
    create_table :shippings do |t|
      t.text :name
      t.float :price

      t.timestamps
    end
  end
end
