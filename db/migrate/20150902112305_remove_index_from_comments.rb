class RemoveIndexFromComments < ActiveRecord::Migration
  def change
    remove_index :comments, column: :article_id
  end
end
