Rails.application.routes.draw do
  root to: 'game#welcome'

  resources :questions do
    resources :answers, only: [:index, :create, :destroy, :update]
  end

  resources :game, only: [:new]

  get '/new-game', to: 'game#new_game'
end
