Rails.application.routes.draw do
  # map out the applications routes
  resources :people, only: [:index, :show, :create, :update, :destroy] do
    get 'versions/:id', to: 'people#show_version'
  end
end
