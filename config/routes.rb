Rails.application.routes.draw do
  resources :dashboard, only: [:index]
  resources :home, only: [:index]
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
