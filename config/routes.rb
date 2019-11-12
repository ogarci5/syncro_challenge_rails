Rails.application.routes.draw do
  resources :metrics
  namespace :api do
    resources :events, only: %i(index create)
  end
end
