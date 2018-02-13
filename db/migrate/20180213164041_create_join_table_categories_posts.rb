class CreateJoinTableCategoriesPosts < ActiveRecord::Migration[5.1]
  def change
    create_join_table :categories, :posts do |t|
      t.index [:post_id, :category_id]
    end
  end
end
