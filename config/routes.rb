Rails.application.routes.draw do
	root 'static_pages#home'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  match '/signup', to: 'users#new', via: 'get'
end
