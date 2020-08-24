Rails.application.routes.draw do
  root 'page#dashboard'
  get 'three_floor', to: 'page#three_floor'
  get 'three_office', to: 'page#three_office'
  
  scope(path_names: { new: 'nuevo', edit: 'editar'}) do
    resources :tokens, only: [:index, :show], path: 'fichas'
    resources :floors, path: 'pisos'
    resources :securities, except: [:destroy], path: 'arl'
    resources :healths, except: [:destroy], path: 'eps'
    resources :offices, path: 'oficinas'
    resources :visitors, path: 'visitantes'
    resources :visits, except: [:index], path: 'visitas'
  end
  
  
  # Floors routes
  get 'floor_offices/:id', to: 'offices#floor_offices'
  
  # Visitors routes
  get 'search_visitor/:dni', to: 'visitors#search_visitor'

  # Visits routes
  put 'give_out/:visit_id', to: 'visits#give_out'
  get 'historial_visitas', to: 'visits#visit_history', as: :visit_history
  get 'visitas_activas', to: 'visits#active_visit', as: :active_visit
  get 'buscar_por_dia', to: 'visits#search_by_date', as: :search_by_date
  get 'buscar_por_visitante', to: 'visits#search_by_visitor', as: :search_by_visitor
  get 'buscar_por_piso', to: 'visits#search_by_floor', as: :search_by_floor
  get 'buscar_por_oficina', to: 'visits#search_by_office', as: :search_by_office
  
  # Reports
  get 'visit_per_day', to: 'visits#visit_per_day', as: :visit_per_day
  get 'visit_per_user', to: 'visits#visit_per_user', as: :visit_per_user
  get 'visit_per_floor', to: 'visits#visit_per_floor', as: :visit_per_floor
  get 'visit_per_office', to: 'visits#visit_per_office', as: :visit_per_office
  get 'get_report', to: 'visits#get_report', as: :get_report

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
