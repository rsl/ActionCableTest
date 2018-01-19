Rails.application.routes.draw do
  resources :lists do
    resources :items
  end

  root to: 'lists#index'
end
