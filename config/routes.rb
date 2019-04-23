Rails.application.routes.draw do  

  root to: 'teams#index'

  resources :teams, only: [:create, :destroy]
  
  # localhost:3000/onebitcode
  # :slug -> onebitcode
  get '/:slug', to: 'teams#show' 

  # resources gera as urls
  resources :channels, only: [:show, :create, :destroy]

  resources :talks, only: [:show]

  resources :team_users, only: [:create, :destroy]
  
  devise_for :users, :controllers => { registrations: 'registrations' }
end
