Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#home'

  get 'signup', to: "users#new"
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :emails, except: [:index,:show, :edit, :update, :destroy]
  get 'emails/inbox', to: 'emails#Email_inbox'
  get 'emails/sent', to: 'emails#Email_sent'
  get 'emails/sent/:id', to: 'emails#Email_sent_show', as: 'email_sent_show'
  get 'emails/inbox/:id', to: 'emails#Email_inbox_show', as: 'email_inbox_show'
  

  put 'block', to: "friends#block"
  put 'unblock', to: "friends#unblock"

  get 'auth/:provider/callback', to: "sessions#create"

  resources :friends
  
end
