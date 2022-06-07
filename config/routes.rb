Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    resources :categories
    namespace :expenses do
      resources :summary, only: [:index]
    end
    resources :expenses
    resources :registrations, only: [:create]
    resource :sessions, only: [:create, :destroy]

    match '*path', via: :all, to: 'route_not_found#route_not_found'
  end
end
