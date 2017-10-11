Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#home'
  get 'about', to: 'welcome#about'

  get 'signup', to: "users#new"
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :emails

  put 'block', to: "friends#block"
  put 'unblock', to: "friends#unblock"

  get 'auth/:provider/callback', to: "sessions#create"

  resources :friends
  
end
