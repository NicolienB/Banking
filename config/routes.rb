Rails.application.routes.draw do
  resources :transactions
  root to: "transactions#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
