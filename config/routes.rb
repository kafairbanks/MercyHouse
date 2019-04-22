Rails.application.routes.draw do

  get 'show_dash', to: 'applicant_dash#show_dash', as: :show_dash
  match 'auth/:provider/callback' => 'sessions#create', :via => [:get]
  match 'auth/failure' => redirect('/'), :via => [:get]
  match '/signout' => 'sessions#destroy', :via => [:delete] , as: "signout"

  resources :mercyrooms
  resources :mercyhomes
  resources :coordinators
  resources :applications
  resources :bookings
  resources :applicants
  resources :reports
  resources :users, only: [:show, :edit, :update, :index]

  get '/login', to: 'login#login', as: 'login'
  get '/calendar', to: 'calendar#calendar', as: 'calendar'
  get '/bookings/new/:id', to: 'bookings#new', as: :app_booking
  get '/success', to: 'applications#success', as: 'success'
  get '/reports/download/:id', to: 'reports#download', as: :report_download, defaults: {format:'csv'}
  post '/calendar', to: 'calendar#calendar'
  root 'login#login'

end
