# config/routes.rb

Rails.application.routes.draw do
  root 'flights#index'

  resources :flights, only: [:index] do
    post 'create_flight', on: :collection
  end

  resources :bookings, only: [:new, :create, :show] do
    resources :passengers, only: [:create]
  end
end
