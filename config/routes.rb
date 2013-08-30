Utility::Application.routes.draw do
  resource :dashboard, controller: :dashboard

  resources :tasks, only: [ :update, :create, :destroy ]

  root to: 'dashboard#show'
end
