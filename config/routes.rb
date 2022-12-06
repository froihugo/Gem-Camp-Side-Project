Rails.application.routes.draw do
  devise_for :users,
             :controllers => {
               :registrations => 'users/registrations',
               :sessions => 'users/sessions',
             }

  resources :users, only: :show, :path => :username
  match '/:username' => 'users#show', :via => :get, as: 'profile'

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
