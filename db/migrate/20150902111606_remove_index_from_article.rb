class RemoveIndexFromArticle < ActiveRecord::Migration
  def change
    remove_index :articles, column: :author_id
  end
end
