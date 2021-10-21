Rails.application.routes.draw do  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # devise_for :users
  devise_for :users, controllers: {   registrations: 'users/registrations',
    sessions: 'users/sessions' }
  resources :users, only: [:index, :show]  
  resources :stocks, only: %i(index create destroy)
  resources :articles do
    collection do
      get :guide
      get :iine_rank
      get :trend_line
    end
    resources :comments
  end
  resources :relationships, only: [:create, :destroy]

  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'

  post 'like/:id' => 'likes#create_stock', as: 'create_like_stock'
  delete 'like/:id' => 'likes#destroy_stock', as: 'destroy_like_stock'

  root to: "articles#top"
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/guest_admin_sign_in', to: 'users/sessions#guest_admin_sign_in'
  end
  resources :tags
end

