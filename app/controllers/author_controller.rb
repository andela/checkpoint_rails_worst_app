class AuthorController < ApplicationController
  def index
    @authors = Author.all
  end
end
