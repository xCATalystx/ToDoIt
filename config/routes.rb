Rails.application.routes.draw do
  # resources :login
  get "/login", to: 'login#index'

  resources :tasks
  # get "/tasks", to: 'tasks#index'
  # get "/tasks/new", to: 'tasks#new'

  # resources :today
  get "/today" , to: 'today#index'

  # resources :next7days
  get "/next7days", to: 'next7days#index'

  root "tasks#index"
  # get "/", to: 'tasks#index'
end
