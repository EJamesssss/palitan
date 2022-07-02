Rails.application.routes.draw do
  get '/dashboard/pending_users', to: 'dashboard#pending_users', as: 'pending_users'
  patch '/dashboard/:id', to: 'dashboard#approved', as: 'confirm_user'
  resources :dashboard
  namespace :dashboard do
    resources :user
  end
  resources :home, only: [:index]
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  devise_for :users


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
