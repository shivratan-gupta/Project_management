Rails.application.routes.draw do
  resources :dashboards
  resources :user_roles
  resources :user_tasks do
    collection do
      get :load_task
    end
  end
  resources :projects do
    resources :tasks
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "dashboards#index"
end
