Rails.application.routes.draw do

  root "home#index"

  resources :boards do
    resources :tickets
  end

end
