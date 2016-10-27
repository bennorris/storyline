Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root 'users#welcome'
  resources :users
  resources :stories do
    resources :sentences do
      resources :upvotes, only: [:new,:create,:edit,:update]
    end
  end

  post '/users', to: 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
