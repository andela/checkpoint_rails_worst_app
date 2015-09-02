class AuthorController < ApplicationController
  def index
    @authors = Author.all
    @prolific_author = Author.most_prolific_writer
  end
end
