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

  # Visits routes
  resources :visits, except: [:index]
  put 'give_out/:visit_id', to: 'visits#give_out'
  get 'visit_history', to: 'visits#visit_history', as: :visit_history
  get 'active_visit', to: 'visits#active_visit', as: :active_visit

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
