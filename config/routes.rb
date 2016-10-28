Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :registrations => 'registrations' }

  root 'users#welcome'
  resources :users
  resources :stories do
    resources :upvotes, only: [:create]
    resources :sentences do
      resources :upvotes, only: [:create]
    end
  end


  get '/user/:id/stats', to: 'users#stats', as: "user_stats"
  post '/users', to: 'users#create'

end
