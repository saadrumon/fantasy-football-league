Rails.application.routes.draw do
  resources :seasons do
    member do
      get :manage_team
      post :manage_team
      get :close
    end
    resources :games
  end
  resources :teams
  resources :players
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
