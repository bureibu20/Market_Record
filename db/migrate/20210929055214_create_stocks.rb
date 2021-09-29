class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :article, index: true, foreign_key: true, null: false
      t.timestamps
      t.index [:user_id, :article_id], unique: true
    end
  end
end
