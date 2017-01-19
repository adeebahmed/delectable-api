Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults:{ format: :json }do
    namespace :delectable do

    end
  end
end