Rails.application.routes.draw do
constraints(ClientDomainConstraint.new) do
    root "home#index"
    devise_for :users, :controllers => { :registrations => 'users/registrations', :sessions => 'users/sessions' }
    resource :users, only: [:show]
    get 'users/:id' => 'users#show', as: :user
  end

  constraints(AdminDomainConstraint.new) do
    namespace :admin do
      resources :users
    end
  end
end
