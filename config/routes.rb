Rails.application.routes.draw do
  get 'articles/show'

  root to: 'author#index'
end
