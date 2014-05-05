ChessCamp::Application.routes.draw do
  get "registrations/new"
  get "registrations/create"
  get "registrations/update"
  get "registrations/edit"
  get "students/index"
  get "students/show"
  get "students/new"
  get "students/edit"
  get "students/create"
  get "students/update"
  get "students/destroy"
  get "families/index"
  get "families/show"
  get "families/new"
  get "families/edit"
  get "families/create"
  get "families/update"
  get "families/destroy"
  get "locations/index"
  get "locations/show"
  get "locations/new"
  get "locations/edit"
  get "locations/create"
  get "locations/update"
  get "locations/destroy"
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "users/new"
  get "users/edit"
  get "users/create"
  get "users/update"
  get "user/new"
  get "user/edit"
  get "user/create"
  get "user/update"
  # generated routes
  resources :curriculums
  resources :instructors
  resources :camps
  resources :users
  resources :sessions
  resources :locations
  resources :families
  resources :students

  # semi-static routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  # set the root url
  root to: 'home#index'

end
