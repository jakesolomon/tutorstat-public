Rails.application.routes.draw do
  root 'tests#index'
  resources :tests, only: [:index]
  resources :tutors, only: [:index]
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :tests, only: [:index]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
