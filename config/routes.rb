Rails.application.routes.draw do
  
  
  root 'page#dashboard'
  
  # Floors routes
  resources :floors
  get 'floor_offices/:id', to: 'offices#floor_offices'
  get 'search_visitor/:dni', to: 'visitors#search_visitor'
  
  # Offices routes
  resources :offices

  # Visitors routes
  resources :visitors

  # Admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # User routes
  devise_for :users, :skip => [:registrations] 
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
