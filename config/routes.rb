Rails.application.routes.draw do
  require 'sidekiq/web'
  mount API::Base, at: "/"
  mount Sidekiq::Web ,at: '/sidekiq'
  devise_for :authors
  root 'apps#index'
  resources :apps
  get '/analytics' => 'apps#analytics'
  get '/customize' => 'apps#customize'
  get '/faq' => 'apps#faq'
  get '/monetize' => 'apps#monetize'
  get '/posts' => 'apps#posts'
  get '/new_notification' => 'apps#push_notification'
  get '/all_notification' => 'apps#all_notification'
  get 'support' => 'apps#support'
  get 'registration' => 'static#registration'

  def after_sign_in_path_for(user)
           apps_path(user)
      end
end
