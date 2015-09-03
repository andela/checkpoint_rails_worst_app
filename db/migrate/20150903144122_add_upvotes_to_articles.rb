class AddUpvotesToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :upvotes, :integer
  end
end
