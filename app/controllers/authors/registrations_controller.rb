class Authors::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
layout "step-form"

before_action :set_pass, only: [:new]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource

def set_pass

  $temp_pass = SecureRandom.hex(5)
end

 
  def create
    @author =  Author.find_by(:email => params[:email])
    #check email with active user exits
    if Author.exists?(:email => params[:email],:author_active => true)

        flash[:notice] = "Email Already taken"
        redirect_to new_author_registration_path
    #check uniqueness of blog_url if email exist
    elsif App.exists?(:app_url => params[:blog_url]) and not @author.nil? and @author.author_active
      # @author_app=1
      flash[:notice] = "Blog Url Already registered"
      redirect_to new_author_registration_path
    #check uniqueness of blog_url and if email not exist 
    elsif App.exists?(:app_url => params[:blog_url]) and @author.nil?
        flash[:notice] = "Blog Url Already registered"
        redirect_to new_author_registration_path    
    else
        $next=0
        @valid_url=check_site(params[:blog_url])
        # byebug
        if @valid_url 

          # binding.pry
            if not @author.nil?
                @author.update(password: params[:author][:password])
                @app =App.find_by(author_id: @author.id)
                @app.update(app_url: params[:blog_url])
            else 
                @author = Author.new
                @author.email = params[:email]
                @author.password = params[:author][:password]
                @author.save
            
                # to create session
                # sign_in @author
                # byebug
                
                @app = App.new
                @app.author_id = @author.id
                @app.app_url = params[:blog_url]
                @app.save
                @app_colours=@app.build_appcolour
                @app_colours.app_id = @app.id
                @app_colours.save
            end
            $current_author=@author
            $next=1

        else
                $next=0

        end  
                       #valid url if ends

      # super
      # byebug

  end  #Author exist

end  #create ends

  def check_site(url)
    url=url[7..-1]
    app_url = 'http://builtwith.com/q=' + url
    @data= 0
    begin
      @response = Nokogiri::HTML(open(app_url))
      @response.css('.techItem a').each do |link|
        if link.content == "WordPress"
          @data = 1
        end
      end
      @data
    rescue
      -1
    end
  end


   def edit
    ResetPassword.perform_async(current_author.email)

    super
  end
 
  private
 
  def sign_up_params

    allow = [:email ,:password, :app_url]
    params.require(resource_name).permit(allow)
  end 

end  #class ends



  # GET /resource/edit
  
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
