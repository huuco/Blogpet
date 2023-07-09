class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true, null: false, index: true
      t.bigint :user_id, null: false, index: true
      t.timestamps

    end
  end
end
