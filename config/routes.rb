Utility::Application.routes.draw do
  resource :dashboard, controller: :dashboard do
    collection do
      get :tasks
      get :email
      get :calendar
    end
  end

  resources :links

  resources :tasks, only: [ :update, :create, :destroy ]

  root to: 'dashboard#show'
end
