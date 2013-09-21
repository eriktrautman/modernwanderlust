Modernwanderlust::Application.routes.draw do

  devise_for :admins
  root :to => 'posts#index'

  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  resources :posts
end
