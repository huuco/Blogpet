class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :min_read
      t.integer :viewer, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
