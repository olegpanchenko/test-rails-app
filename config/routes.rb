Rails.application.routes.draw do

  resources :order_items, only: [:destroy]
  resources :discounts, only: [] do
    member do
      post 'remove_from_basket'
    end
  end

  resources :orders, only: [:update, :show] do
    collection do
      get 'purchase'
    end
  end

  resources :items, only: [:index, :show] do
    member do
      post 'add_to_basket'
      post 'remove_from_basket'
    end
  end

  root to: "items#index"
end
