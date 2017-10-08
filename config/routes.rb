Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#home'
  get 'about', to: 'welcome#about'

  get 'signup', to: "users#new"
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :emails, except: [:index, :show]
  get 'emails/inbox', to: 'emails#Email_inbox'
  get 'emails/sent', to: 'emails#Email_sent'
  get 'emails/sent/:id', to: 'email#Email_sent_show', as: 'email_sent_show'
  get 'emails/inbox/:id', to: 'emails#Email_inbox_show', as: 'email_inbox_show'
  

  get 'auth/:provider/callback', to: "sessions#create"
  
end
