Rails.application.routes.draw do
  get 'comments/new'
  post 'comments/create', as: "comments"

  get 'articles/show'
  root to: 'author#index'
end
