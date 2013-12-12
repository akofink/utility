Utility::Application.routes.draw do
  resources :dashboard, controller: :dashboard

  resources :links

  resources :user_sessions, only: [ :new, :create ] do
    collection do
      delete :destroy
    end
  end

  resources :tasks, only: [ :update, :create, :destroy ]

  resources :users

  root to: 'user_sessions#new'
end
