Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: [:index, :show]
  resources :stocks, only: %i(index create destroy)
  resources :articles
  root to: "articles#index"
end

