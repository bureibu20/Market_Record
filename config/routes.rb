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
    end
    resources :comments
  end
  resources :relationships, only: [:create, :destroy]
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  root to: "articles#top"
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/guest_admin_sign_in', to: 'users/sessions#guest_admin_sign_in'
  end
  resources :tags
end

