class ArticlesController < ApplicationController
  def show
    @article = Article.find(params["format"])
  end
end
