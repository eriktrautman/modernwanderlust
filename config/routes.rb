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
  get "archives" => "posts#archives"
  get "blog" => "posts#index"

  resources :posts

  get "sitemap.xml" => "sitemap#index", :as => "sitemap", :defaults => { :format => "xml" }
end
