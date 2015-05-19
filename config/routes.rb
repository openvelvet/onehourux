Rails.application.routes.draw do
  
  get "/messages" => redirect("/conversations")
  resources :messages do
  member do
    post :new
  end
end
resources :conversations do
  member do
    post :reply
    post :trash
    post :untrash
  end
 collection do
    get :trashbin
    post :empty_trash
 end
end

  resources :recruiters, except: [:index, :show]

  # devise for users
  devise_for :users, :controllers => { :sessions => "sessions", :registrations => "registrations", :omniauth_callbacks => "callbacks" }
  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end
  
  resources :profiles do
    resources :orders 
  end

  post '/complete_purchase/:id' => "orders#complete_purchase", as: :complete_purchase
  get 'cindarella/:id' => "orders#cindarella"
  
  get "sales" => "orders#sales"

  # profiles controller
  get 'complete_profile' => "profiles#complete_profile" #show of /profiles/:id
  
  # routes for pages controller
  get 'pages/about'
  get 'pages/contact'
  get 'home' => "pages/home"
  get 'pages/type'

  # Home page
  root 'pages#home'

  # Redirects user to root path and shows an error message
  # get '*a' => redirect { |p, req| req.flash[:error] = "aaargh, you don't want to go to #{p[:a]}"; '/' }


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
