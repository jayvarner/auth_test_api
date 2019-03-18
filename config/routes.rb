Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/tokens/:token', to: 'tokens#show'
  resources :tokens
end