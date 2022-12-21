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

    namespace :api do
      resources :regions, only: :index, defaults: { format: :json } do
        resources :provinces, only: :index, defaults: { format: :json } do
          resources :cities, only: :index, defaults: { format: :json } do
            resources :barangays, only: :index, defaults: { format: :json }
          end
        end
      end
    end

    namespace :users, only: [:show], :path => '/:username' do
      resources :invites, only: :index
    end

  end

  constraints(AdminDomainConstraint.new) do
    get '/',  to: "admin/home#index", as: 'admin_root'
      namespace :admin do
      devise_for :users, controllers: { sessions: 'admin/sessions' }
        get 'users', to: 'users#index'
      end
    end
  end