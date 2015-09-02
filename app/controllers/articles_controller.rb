class ArticlesController < ApplicationController
  def index
    
  end

  def show
    @article = Article.find(params["format"])
  end
end
