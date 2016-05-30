class Authors::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]


before_action :set_pass, only: [:new]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource

def set_pass

  $temp_pass = SecureRandom.hex(5)
end

 
  def create
    
    super


        # binding.pry

        @author_email  = params[:author][:email]

        SignupMail.perform_async(@author_email,$temp_pass)



       @find_author_id =  Author.find_by(:email => params[:author][:email]).id

        @app = App.new

        @app.author_id = @find_author_id


        @app.app_url = params[:blog_url]

        @app.save

end

  private
 
  def sign_up_params

  
    allow = [:email ,:password]
    params.require(resource_name).permit(allow)
  end

   end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
