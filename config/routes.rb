Rails.application.routes.draw do
  resources :conversations, only: %i[index create]
  resources :messages, only: %i[create show]
  post 'login', to: 'authentication#create'
end
