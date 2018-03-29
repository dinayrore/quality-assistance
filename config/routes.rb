Rails.application.routes.draw do
  root to: 'pages#home'

  get '/email-requirements', to: 'pages#requirements'
  get '/dm-requirements', to: 'pages#requirements'
end
