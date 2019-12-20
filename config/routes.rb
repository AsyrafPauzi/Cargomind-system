Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    root to: "users#index"
  end
  devise_scope :admin do
  end
  resources :users, only: [:index]
  namespace :users do
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
    end
  end
  resources :admins, only: [:index]
  namespace :admins do
    namespace :manage do
      resources :shipments
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

