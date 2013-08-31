Utility::Application.routes.draw do
  resource :dashboard, controller: :dashboard do
    collection do
      get :tasks
    end
  end

  resources :tasks, only: [ :update, :create, :destroy ]

  root to: 'dashboard#show'
end
