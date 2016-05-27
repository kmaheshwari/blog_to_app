Rails.application.routes.draw do
  require 'sidekiq/web'
  mount API::Base, at: "/"
  mount Sidekiq::Web ,at: '/sidekiq'
  
  root 'apps#index'
  resources :apps

devise_for :authors, :controllers => {:registrations => "authors/registrations"}


  get 'posts' => 'apps#posts'
  get 'new_notification' => 'apps#push_notification'
  get 'all_notification' => 'apps#all_notification'
  get 'customize' => 'apps#customize'
    get 'support' => 'apps#support'


  def after_sign_in_path_for(user)
           apps_path(user)
      end
end
