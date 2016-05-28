class AuthorsController < ApplicationController

 skip_before_action :verify_authenticity_token



	def basicinfo

		@author = Author.new


	end


	def user_create
         binding.pry

		@author = Author.new

  
		@author.email = params[:email]

		@author.save

        @app = App.new
		@app.app_url = params[:url]
		@app.author_id = @authod.id
	end

end
