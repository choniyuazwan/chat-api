Rails.application.routes.draw do
  resources :conversations, only: %i[index]
  resources :messages, only: %i[create show]
  post 'login', to: 'authentication#create'
end
