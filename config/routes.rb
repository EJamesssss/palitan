Rails.application.routes.draw do
  get '/dashboard/pending_users', to: 'dashboard#pending_users', as: 'pending_users'
  resources :dashboard
  resources :home, only: [:index]
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  devise_for :users
  resources :users


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
