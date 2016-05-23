Rails.application.routes.draw do
  mount API::Base, at: "/"
  devise_for :authors
  root 'apps#index'
  resources :apps
  def after_sign_in_path_for(user)
           apps_path(user)
      end
end
