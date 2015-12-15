Rails.application.routes.draw do

  namespace :mobile do


    # customer
    get 'register' => 'sessions#register', :as => 'register'
    post 'sign_up' => 'sessions#sign_up', :as => 'sign_up'
    get 'login' => 'sessions#login', :as => 'login'
    post 'login' => 'sessions#sign_in', :as => 'sign_in'
    get 'contact' => 'sessions#contact', :as => 'contact_us'

    # checkout
    get 'checkout/order' => 'checkout#order', :as => 'checkout_order'
    post 'checkout/order' => 'checkout#update', :as => 'update_checkout_order'
    get 'checkout/detail/:id' => 'checkout#detail', :as => 'checkout_order_detail'
    post 'checkout/confirm' => 'checkout#confirm', :as => 'confirm_order'

    post 'checkout' => 'checkout#update', :as => 'checkout'

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

    # address
    post 'region_city' => 'regions#city', :as => 'region_city'
    post 'region_district' => 'regions#district', :as => 'region_district'

    get 'addresses/manage' =>  'addresses#manage', :as  => 'manage_addresses'
    resources :addresses do
      member do
        post 'set_default'
      end
    end

  end

end