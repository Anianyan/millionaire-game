Rails.application.routes.draw do
  root to: 'game#welcome'

  resources :questions do
    resources :answers
  end

  resources :game, only: [:new]

  get '/new-game', to: 'game#new_game'
  post '/game/next', to: 'game#get_next'
end
