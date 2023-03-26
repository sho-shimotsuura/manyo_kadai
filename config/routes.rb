Rails.application.routes.draw do
  resources :sessions
  resources :users
  namespace :admin do
    resources :users
  end
  root to: 'tasks#index'
  resources :tasks do
    collection do
      get 'search'
    end  
  end
end
