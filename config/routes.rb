Rails.application.routes.draw do
  # Devise routes for User authentication
  devise_for :users

  root to: "home#index"
  # Publicly accessible routes
  get "home/index" # Landing page
  get "setting/index"
  get "patient/index"

  # Settings section
  resources :patient
   # Add the profile routes above users resource
   get '/profile/edit', to: 'users#edit_profile', as: :edit_profile
   patch '/profile', to: 'users#update_profile', as: :update_profile
 
  resources :users, except: [:show]

  # Root path routing depending on auth status
  # authenticated :user do
  #   root to: "dashboard#index", as: :authenticated_root
  # end

  unauthenticated do
    root to: "devise/sessions#new", as: :unauthenticated_root
  end

  get "/dashboard", to: "dashboard#index", as: :dashboard
end
