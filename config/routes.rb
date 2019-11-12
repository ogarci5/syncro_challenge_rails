Rails.application.routes.draw do
  root to: 'metrics#index'
  namespace :api do
    resources :events, only: %i(index create)
  end
end
