Rails.application.routes.draw do
  resources :people, only: [:index, :show, :create, :update, :destroy]
end
