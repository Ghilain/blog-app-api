# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create, :destroy]
  end
  end

  get 'users/:user_id/posts_list', to: 'api#list_all_post_of_user', as: :list_all_post_of_user
  get 'users/:user_id/posts/:post_id/comments_list', to: 'api#list_of_all_comments_post', as: :list_of_all_comments_post
  post 'users/:user_id/posts/:post_id/add_comment', to: 'api#add_comment', as: :add_comment

end
