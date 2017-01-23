Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults:{ format: :json }do
    namespace :delectable do
      #devise_for :users
      resources :users, :only => [:show, :create]
    end
  end
end