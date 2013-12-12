Utility::Application.routes.draw do
  resource :dashboard, controller: :dashboard do
    collection do
      get :tasks
      get :email
      get :calendar
    end
  end

  resources :links

  resources :user_sessions, only: [ :new, :create ] do
    collection do
      delete :destroy
    end
  end

  resources :tasks, only: [ :update, :create, :destroy ]

  resources :users

  root to: 'dashboard#show'
end
