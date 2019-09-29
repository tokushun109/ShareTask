Rails.application.routes.draw do

  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:new, :create, :edit, :update] do
    collection do
      get :search
    end
  end
  
  resources :groups, only: [:index, :new, :create, :show]
  resources :relationships, only: [:create]
end
