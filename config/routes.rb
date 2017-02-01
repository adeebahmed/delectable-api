Rails.application.routes.draw do
  devise_for :menus
  devise_for :reports
  devise_for :admins
  devise_for :orders
  devise_for :users
  namespace :api, defaults:{ format: :json }do
    namespace :delectable do
      resources :users, :only => [:index, :show, :create, :update, :destroy, :search]
      resources :menus, :only => [:index, :show, :create, :update, :destroy]
    end
  end
end