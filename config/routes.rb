Rails.application.routes.draw do
  resources :conversations, only: %i[index create]
  post 'login', to: 'authentication#create'
end
