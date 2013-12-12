Utility::Application.routes.draw do
  resources :dashboards, constraints: { id: /.+/ } do
    collection do
      get :tasks
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

  get 'dashboard', to: 'dashboards#show'

  root to: 'user_sessions#new'
end
