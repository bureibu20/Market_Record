Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: [:index, :show]
  resources :stocks, only: %i(index create destroy)
  resources :articles do
    resources :comments
  end
  root to: "articles#index"
end

