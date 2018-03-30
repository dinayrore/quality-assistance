Rails.application.routes.draw do
  root to: 'pages#home'

  get '/email-pg-worksheet', to: 'pages#worksheet'
  get '/dm-pg-worksheet', to: 'pages#worksheet'
  get '/validating', to: 'pages#validation'
end
