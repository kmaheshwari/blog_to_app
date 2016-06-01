class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

	def current_app
	  @app_path = App.find_by(:author_id =>current_author.id)
	end
  	helper_method :current_app
end
