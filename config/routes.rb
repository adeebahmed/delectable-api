Rails.application.routes.draw do
  devise_for :reports
  devise_for :admins
  devise_for :menus
  devise_for :orders
  devise_for :users
  namespace :api, defaults:{ format: :json }do
    namespace :delectable do
      #devise_for :users
      resources :users, :only => [:index, :show, :create, :update, :destroy, :search]
    end
  end
end