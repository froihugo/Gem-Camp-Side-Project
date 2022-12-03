Rails.application.routes.draw do
  devise_for :user,
             :controllers => {
               :registrations => 'users/registrations',
               :sessions => 'users/sessions',
             }
resources :users
get '/users/:id', to: 'users#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  constraints(ClientDomainConstraint.new) do
  end

  constraints(AdminDomainConstraint.new) do
    namespace :admin do
      resources :users
    end
  end
end
