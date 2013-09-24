Modernwanderlust::Application.routes.draw do

  devise_for :admins do
  end

  devise_scope :admin do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end
    
  root :to => 'posts#index'

  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "show_post" => "redirects#old_site"

  resources :posts
end
