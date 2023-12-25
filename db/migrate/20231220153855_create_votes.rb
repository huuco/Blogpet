class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.boolean :vote_flag
      t.references :user, null: false, foreign_key: true
      t.references :blog, null: false, foreign_key: true

      t.timestamps
    end
    add_index :votes, [:user_id, :blog_id, :vote_flag], unique: true
  end
end
