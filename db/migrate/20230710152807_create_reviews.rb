class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :product_id], name: :index_user_id_product_id_for_review_uniq, unique: true
    end
  end
end
