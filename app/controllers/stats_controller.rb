class StatsController < ApplicationController
  def index
    @five_longest_article_names = Article.five_longest_article_names
    @prolific_author = Author.most_prolific_writer
    @author_with_most_upvoted_article = Author.with_most_upvoted_article
    @article_names = Article.all_names

  end
end
