Rails.application.routes.draw do
  resources :symbols, only: [:index, :show]
end
