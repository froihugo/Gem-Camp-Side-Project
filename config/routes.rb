Rails.application.routes.draw do
  constraints(ClientDomainConstraint.new) do
    devise_for :users, :controllers => { :registrations => 'users/registrations', :sessions => 'users/sessions' }
    root "home#index"
    get 'address_book', to: 'users/addresses#index'
    resource :users, only: [:show], :path => '/:username' do
      resources :addresses, except: [:index], :controller => 'users/addresses'
      post 'addresses/new', to: 'users/addresses#create'
      patch 'addresses/edit', to: 'users/addresses#update'
    end
  end

  constraints(AdminDomainConstraint.new) do
    namespace :admin do
      resources :users
    end
  end
end
