Rails.application.routes.draw do
  devise_for :clients, controllers: {
    sessions: 'clients/sessions',passwords: 'clients/passwords',registrations: 'clients/registrations',confirmations: 'clients/confirmations'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',registrations: 'clients/registrations'
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
  resources :users, only: [:index] do
    collection do
      post '/post_status/', to: 'users#post_status', as: 'post_status'
      delete '/delete_status/:id', to: 'users#delete_status', as: 'delete_status'
    end
  end
  namespace :users do
 
    namespace :manage do
      resources :shipments do
        collection do
          patch '/assign_user/:id', to: 'shipments#assign_user', as: 'assign_user'
          patch '/send_quotation/:id', to: 'shipments#send_quotation', as: 'send_quotation'
          patch '/client_update/:id', to: 'shipments#client_update', as: 'client_update'
          get '/booking/', to: 'shipments#booking', as: 'booking'
          get '/bill_of_lading/:id', to: 'shipments#bill_of_lading', as: 'bill_of_lading'
          patch '/update_bill_of_lading/:id', to: 'shipments#update_bill_of_lading', as: 'update_bill_of_lading'
          get '/view_bill_of_lading/:id', to: 'shipments#view_bill_of_lading', as: 'view_bill_of_lading'
          get '/awb/:id', to: 'shipments#awb', as: 'awb'
          patch '/update_awb/:id', to: 'shipments#update_awb', as: 'update_awb'
          get '/view_awb/:id', to: 'shipments#view_awb', as: 'view_awb'
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
          patch '/update_collection_replanned/:id', to: 'cargo_collections#update_collection_replanned', as: 'update_collection_replanned'
        end
      end
      resources :cargo_declarations do
        collection do
          patch '/update_declaration/:id', to: 'cargo_declarations#client_update', as: 'client_update'
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

