Rails.application.routes.draw do
  devise_for :menus
  devise_for :reports
  devise_for :admins
  devise_for :orders
  devise_for :users
  namespace :api, defaults:{ format: :json }do
    namespace :delectable do
      resources :users, :only => [:index, :show, :create, :update, :destroy]

      post "admin", to: "admin#create"
      get "admin", to: "admin#index"
      post "admin/menu", to:"admin#show"
      put "admin/menu/:id", to:"admin#updatemenu"
      get "admin/surcharge", to: "admin#getsurcharge"
      post "admin/surcharge", to: "admin#postsurcharge"
      post "admin/delivery/:id", to:"admin#delivered"

      get "menu", to: "menu#index"
      get "menu/:id", to: "menu#show"

      get "order", to: "order#index"
      get "order/:id", to: "order#show"
      put "order", to: "order#create"
      post "order/cancel/:id", to: "order#cancel"

    end
  end
end