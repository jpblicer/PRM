Rails.application.routes.draw do
  get 'event_contacts/create'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  post 'contacts/extract_business_card', to: 'contacts#extract_business_card'
  resources :dashboard, only: [:index]
  resources :contacts, except: [:destroy]
  resources :companies, except: [:destroy, :edit]
  resources :events, only: [:index, :new, :create, :show]
  resources :todos, only: [:index, :new, :create, :update]
  resources :notes, only: [:create]
  resources :event_contacts, only: [:create]

end
