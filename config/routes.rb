Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :registrations => 'registrations' }

  root 'users#show'
  resources :users , only: [:create, :new, :edit, :update, :destroy, :show] do
    resources :stories, only: [:index, :show]
    resources :sentences, only: [:index]
  end

  resources :stories, only: [:create, :new, :show, :destroy, :index] do
    resources :upvotes, only: [:create, :show]
    resources :sentences do
      resources :upvotes, only: [:create, :show]
    end
  end

  resources :genres, only: [:new, :create]
  get '/user/:id/stats', to: 'users#stats', as: "user_stats"
  post '/users', to: 'users#create'
  get '/sentences', to: 'sentences#index'
  get '/get_id', to: 'users#get_id'
  get '/all_stories', to: 'stories#all_stories'
end
