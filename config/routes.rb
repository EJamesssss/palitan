Rails.application.routes.draw do

  get '/admin/users/pending_users', to: 'admin/users#pending_users', as: 'pending_users'
  patch '/admin/users/approve/:id', to: 'admin/users#approved', as: 'confirm_user'
  
  namespace :admin do
    resources :users
  end

  resources :dashboard, only: [:index]
  resources :home, only: [:index]
  resources :transactions , only: [:index, :new, :create]
  
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  devise_for :users

  resources :portfolio


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
