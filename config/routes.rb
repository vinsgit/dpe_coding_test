Rails.application.routes.draw do
  namespace :api do
    resources :products, only: [:show, :index] do
      post 'import', on: :collection
    end

    resources :carts, only: [] do
      collection do
        put :add
        post :place_order
      end
    end

    resources :users, only: [:index]
  end
end
