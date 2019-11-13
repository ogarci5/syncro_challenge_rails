Rails.application.routes.draw do
  root to: 'metrics#index'
  namespace :api do
    resources :events, only: %i(index create) do
      collection do
        get :statistics
      end
    end
  end
end
