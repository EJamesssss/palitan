Rails.application.routes.draw do
  namespace :trader do
    post '/transactions/:id', to: 'transactions#show', as: 'symbol_search'
    resources :transactions, only: [:index, :show, :new, :create]
    
  end
  get '/admin/users/pending_users', to: 'admin/users#pending_users', as: 'pending_users'
  patch '/admin/users/approve/:id', to: 'admin/users#approved', as: 'confirm_user'
  namespace :admin do
    resources :users
  end

  resources :dashboard, only: [:index]
  resources :home, only: [:index]
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  devise_for :users


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
