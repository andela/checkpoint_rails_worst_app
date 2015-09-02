class CommentsController < ApplicationController
  def new
    @article = Article.find(params[:article])
    @comment = Comment.new
  end

  def create
    article = Article.find(params[:comment][:article].to_i)
    article.comments << Comment.create(author: params[:comment][:author], body: params[:comment][:body])
    redirect_to articles_show_path(article)
  end
end
