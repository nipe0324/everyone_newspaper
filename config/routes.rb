Rails.application.routes.draw do
	# Static Pages
	root 'static_pages#home'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  # User Pages
  resources :users
  resource :sessions, only: [:new, :create, :destroy]
  match '/signup',	to: 'users#new', via: 'get'
  match '/login',		to: 'sessions#new', via: 'get'
  match '/logout',	to: 'sessions#destroy', via: 'delete'

end
