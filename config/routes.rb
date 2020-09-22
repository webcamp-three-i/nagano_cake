Rails.application.routes.draw do


  # admin
    devise_for :admins, controllers:{
      sessions: 'admins/sessions',
      passwords: 'admins/passwords',
      registrations: 'admins/registrations'
    }
  	namespace :admin do
  	resources :customers,only: [:index, :show, :edit, :update]
  	resources :products,only: [:index, :new, :create, :show, :edit, :update]
  	resources :genres,only: [:index,:create,:edit,:update, :show]

  	resources :orders,only: [:index,:show,:update]
    resources :order_products,only: [:index, :show, :update]

  	get 'search' => 'search#search'
  	end

    get  'admins/top' => 'admin/home#top'

   # customer
   devise_for :customers, :controllers => {
    :sessions => 'customers/sessions',
    :registrations => 'customers/registrations',
    :passwords => 'customers/passwords'
   }

    root 'customer/home#top'
  	get 'home/about' => 'customer/home#about'

  scope module: :customer do
    resources :customers,only: [:show, :edit, :update] do
  		member do
  	     get 'quit', to: 'customers#quit'
  	     patch 'out', to: 'customers#out'
  	  end
  	end
  end

   	namespace :customer do
    resources :products,only: [:index,:show]


  	resources :cart_items,only: [:index,:update,:create,:destroy] do
        collection do
        delete 'destroy_all'
       end
    end

      resources :orders,only: [:new,:index,:show,:create] do
        collection do
         post 'confirm'
         get 'thanks'
       end
     end

       resources :shipping_addresses,only: [:index,:create,:edit,:update,:destroy]

end
end
