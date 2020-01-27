Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   resources :currency_conversions
   root to: "currency_conversions#index"
end
