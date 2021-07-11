Rails.application.routes.draw do
  # resources :login
  # get "/login", to: 'login#index'

  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#create'
  get 'password/reset/edit', to: 'password_resets#edit'
  patch 'password/reset/edit', to: 'password_resets#update'


  resources :tasks do
    collection do
      get :search
    end
    
    resources :notes, shallow: true,
               except: [:index, :show, :new]
  end
  # get "/tasks", to: 'tasks#index'
  # get "/tasks/new", to: 'tasks#new'

  root "tasks#index"
  # get "/", to: 'tasks#index'
end
