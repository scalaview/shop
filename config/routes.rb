Rails.application.routes.draw do
  mount Shoppe::Engine => "/shoppe"

  root :to => 'pages#index'
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

  # customer
  get 'register' => 'sessions#register', :as => 'register'
  post 'sign_up' => 'sessions#sign_up', :as => 'sign_up'
  get 'login' => 'sessions#login', :as => 'login'
  post 'login' => 'sessions#sign_in', :as => 'sign_in'
  get 'contact' => 'sessions#contact', :as => 'contact_us'

  #
  # Product browising
  #
  get 'products' => 'products#categories', :as => 'catalogue'
  get 'products/filter' => 'products#filter', :as => 'product_filter'
  get 'products/:category_id' => 'products#index', :as => 'products'
  get 'products/:id/:name' => 'products#show', :as => 'product'
  post 'products/:category_id/:product_id/buy' => 'products#add_to_basket', :as => 'buy_product'

  get 'categories/:id/:name' => 'categories#show', :as => 'categories'

  # shopping cart
  post 'add_to_cart' => 'shopping_cart#add_to_cart', :as => 'add_to_cart'
  put 'shopping_cart/:id' => 'shopping_cart#update', :as => 'update_shopping_cart'
  post 'checkout_prepare' => 'shopping_cart#checkout_prepare', :as => 'checkout_prepare'
  get 'shopping_cart' =>  'shopping_cart#show', :as  => 'shopping_cart'


  get 'demo' =>  'shopping_cart#demo', :as  => 'demo'

  get 'checkout/shipping' => 'checkout#shipping', :as => 'checkout_shipping'

  post 'region_city' => 'regions#city', :as => 'region_city'
  post 'region_district' => 'regions#district', :as => 'region_district'

  resources :addresses do
    member do
      post 'set_default'
    end
  end

end
