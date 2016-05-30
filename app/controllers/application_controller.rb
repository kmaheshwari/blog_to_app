class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

   before_action :current_app

    def current_app
    	if author_signed_in?
            @app_path = App.find_by(:author_id =>current_author.id)
        end
    end
  
end
