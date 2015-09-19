Rails.application.routes.draw do

  root "home#index"

  resources :boards do
    resources :tickets do
      member do
        get :ready
        get :cancel
        get :start
        get :stop
        get :complete
        get :restart
      end
    end
  end

end
