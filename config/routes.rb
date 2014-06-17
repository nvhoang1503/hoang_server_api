HoangServerApi::Application.routes.draw do
  mount RailsAdmin::Engine => 'rails_admin'
  root "home#index"

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do

      devise_for :users

      as :user do
        put 'users/change_password' => 'passwords#change_password'
        put 'users/forgot_password' => 'passwords#forgot_password'
      end

      resources :bookings, :only => [:create] do
        collection do
          put 'confirm'
        end
      end

      resources :drivers, :only => [] do
        collection do 
          put "update_status"
        end
      end
    end
  end
  apipie
end
