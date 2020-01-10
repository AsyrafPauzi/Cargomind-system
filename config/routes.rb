Rails.application.routes.draw do
  devise_for :clients, controllers: {
    sessions: 'clients/sessions'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    
  end
  devise_scope :admin do
  end
  devise_scope :client do
    root to: "clients#index"
  end
  resources :users, only: [:index]
  namespace :users do
    namespace :manage do
      resources :shipments do
        collection do
          patch '/assign_user/:id', to: 'shipments#assign_user', as: 'assign_user'
          patch '/send_quotation/:id', to: 'shipments#send_quotation', as: 'send_quotation'
          get '/booking/', to: 'shipments#booking', as: 'booking'
          get '/bill_of_lading/', to: 'shipments#bill_of_lading', as: 'bill_of_lading'
        end
      end
      resources :profiles do
        collection do
        end
      end
      resources :bookings do
        collection do
        end
      end
      resources :cargo_collections do
        collection do
          patch '/update_collection/:id', to: 'cargo_collections#update_collection', as: 'update_collection'
        end
      end
      resources :cargo_declarations do
        collection do
          patch '/update_declaration/:id', to: 'cargo_declarations#client_update', as: 'client_update'
        end
      end
      resources :cargo_submissions do
        collection do
        end
      end
      resources :bookings do
        collection do
        end
      end
      resources :slbl_confirmations do
        collection do
          patch '/update_slbl_confirmation/:id', to: 'slbl_confirmations#client_update', as: 'client_update'
        end
      end
      resources :flight_departs do
        collection do
        end
      end
      resources :vessel_departs do
        collection do
        end
      end
      resources :attach_pre_alerts do
        collection do
        end
      end
      resources :billings do
        collection do
        end
      end
      resources :insurances do
        collection do
        end
      end
    end
  end
  resources :admins, only: [:index]
  namespace :admins do
    namespace :manage do
      resources :shipments
      resources :clients
      resources :users
    end
  end
  resources :clients, only: [:index]
  namespace :clients do
    namespace :manage do
      resources :shipments do
        collection do
          get '/booking/', to: 'shipments#booking', as: 'booking'
          get '/bill_of_lading/', to: 'shipments#bill_of_lading', as: 'bill_of_lading'
        end
      end
      resources :profiles do
        collection do
        end
      end
      resources :customers do
        collection do
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

