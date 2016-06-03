Rails.application.routes.draw do
  # resources :payments
  require 'sidekiq/web'
  mount API::Base, at: "/"
  mount Sidekiq::Web ,at: '/sidekiq'  
  root 'apps#index'
  resources :apps

  devise_for :authors, :controllers => {:registrations => "authors/registrations",:sessions => "authors/sessions"}

  get '/posts' => 'apps#posts'

  get '/new_notification' => 'apps#push_notification'
  get '/all_notification' => 'apps#all_notification'
  get '/analytics' => 'apps#analytics'
  get '/customize' => 'apps#customize'
  get '/faq' => 'apps#faq'
  get '/monetize' => 'apps#monetize'
  post '/get_monetize' => 'apps#get_monetize'
  get '/new_notification' => 'apps#push_notification'
  get '/all_notification' => 'apps#all_notification'
  get '/payments' => 'payments#new'
  post '/payments' => 'payments#create'
  get 'payment_fail' => 'payments#payment_fail'
  post '/check_site'=> 'registrations#check_site'
  get 'support' => 'apps#support'

  # get 'registration' => 'static#registration'


end
