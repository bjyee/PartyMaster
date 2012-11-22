PartyMaster::Application.routes.draw do

  get "home/home"

  resources :party_types
  resources :invitations
  resources :locations
  resources :sessions
  resources :users
  resources :guests
  resources :parties
  resources :hosts
  resources :rsvps

  match 'host/edit' => 'hosts#edit', :as => :edit_current_host
  match 'signup' => 'hosts#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  match 'home' => 'home#home', :as => :home
  match 'about' => 'home#about', :as => :about
  match 'contact' => 'home#contact', :as => :contact
  match 'privacy' => 'home#privacy', :as => :privacy
  match 'rvsp' => 'rsvps#new', :as => :rsvp
  match 'rvsp/edit' => 'rsvps#edit', :as => :edit_rsvp

  root :to => 'home#home'
  
end
