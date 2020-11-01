Rails.application.routes.draw do
  root to: 'game#welcome', as: :home_page

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  namespace :admin do
    resources :questions, :users, only: [:index, :show]
  end

  resources :questions do
    resources :answers
  end
  get '/questions/:question_id/correct-answers', to: 'answers#get_correct'

  resources :game, only: [:new]
  get '/new-game', to: 'game#new_game'
  post '/game/next', to: 'game#get_next_question'

end
