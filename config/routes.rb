Keypunch::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'logout' => 'devise/sessions#destroy'
    get 'login' => 'devise/sessions#new'
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  resources :groups, :except => [ :destroy ] do
    resources :entities, only: [:new, :create]
  end

  #resources :entities, :except => [ :destroy ] do
  resources :entities do
    member do
      get 'show_password'
    end
  end
  resource :home, :only => [ :index ]
  resources :keepass, only:  [ :index, :new, :create ]
  resources :users, except: [:new, :create, :destroy]

  root :to => 'home#index'
end
