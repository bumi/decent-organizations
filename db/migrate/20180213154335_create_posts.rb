class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :url
      t.integer :upvotes, default: 0

      t.timestamps
    end
  end
end
