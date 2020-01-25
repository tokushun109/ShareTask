# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'toppages#index'
  get 'how_to_use', to: 'manuals#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: %i[new create edit update] do
    member do
      get :edit_pw
    end
    collection do
      get :search
      get :group_users
      delete :expulsion
    end
  end

  resources :groups, only: %i[index new create show edit update destroy]
  resources :relationships, only: [:create] do
    collection do
      get :invite
      put :accept
      delete :deny
    end
  end
  resources :tasks, only: %i[new create show edit update destroy] do
    member do
      put :complete
      put :incomplete
    end
  end
  resources :records, only: %i[new create edit update destroy]
end
