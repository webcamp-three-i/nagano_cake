Rails.application.routes.draw do


  # admin
    devise_for :admin
  	namespace :admin do
  	resources :customers,only: [:index, :show, :edit, :update]
  	resources :products,only: [:index, :new, :create, :show, :edit, :update,]
  	resources :genres,only: [:index,:create,:edit,:update, :show]

  	resources :orders,only: [:index,:show,:update]
    resource :order_products,only: [:update]


  	get 'top' => 'home#top'
  	get 'search' => 'search#search'
  	end

   # customer
   devise_for :customers, :controllers => {
    :sessions => 'customers/sessions',
    :registrations => 'customers/registrations',
    :passwords => 'customers/passwords'
   }

  	get 'home/about' => 'customer/home#about'
    root 'customer/home#top'


  scope module: :customer do
    resource :customers,only: [:show, :edit, :update] do
  		collection do
  	     get 'quit'
  	     patch 'out'
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
