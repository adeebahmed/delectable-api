Rails.application.routes.draw do
  devise_for :menus
  devise_for :reports
  devise_for :admins
  devise_for :orders
  devise_for :users
  namespace :api, defaults:{ format: :json }do
    namespace :delectable do
      resources :users, :only => [:index, :show, :create, :update, :destroy]
      resources :menus, :only => [:index, :show, :create, :update, :destroy]
      #resources :admins, :collections => [:menu => :put, :menu => :post] #:only => [:index, :show, :create, :update, :destroy]

      post "admin", to: "admin#create"
      get "admin", to: "admin#index"
      post "admin/menu", to:"admin#show"
      put "admin/menu/:id", to:"admin#updatemenu"
      get "admin/surcharge", to: "admin#getsurcharge"
      post "admin/surcharge", to: "admin#postsurcharge"
      #get "admins/:id", to:"admin#show"

      get "menu", to: "menu#index"
    end
  end
end