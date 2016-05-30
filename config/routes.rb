Rails.application.routes.draw do
  # resources :payments
  require 'sidekiq/web'
  mount API::Base, at: "/"
  mount Sidekiq::Web ,at: '/sidekiq'
  devise_for :authors
  root 'apps#index'
  resources :apps
  get 'posts' => 'apps#posts'
  get 'new_notification' => 'apps#push_notification'
  get 'all_notification' => 'apps#all_notification'
  get 'customize' => 'apps#customize'
  get 'support' => 'apps#support'
  get 'registration' => 'static#registration'
  get 'payments' => 'payments#new'
  post 'payments' => 'payments#create'
  get 'payment_fail' => 'payments#payment_fail'
  def after_sign_in_path_for(user)
           apps_path(user)
      end
end
