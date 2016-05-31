class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]
  # protect_from_forgery 
  layout "step-form", only: [:customize]
  before_filter :authenticate_author! 


  # GET /apps
  # GET /apps.json
  def index
    @apps = App.all
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
  end

  # GET /apps/new
  def new
    end

  # GET /apps/1/edit
  def edit
    @app = App.find_by(:author_id =>current_author.id)
  end

  # POST /apps
  # POST /apps.json
  def create
  end

  # PATCH/PUT /apps/1
  # PATCH/PUT /apps/1.json
  def update
    @app = App.find_by(:author_id =>current_author.id)
    
    @app.app_name = params[:app_name]
    @app.contact_email = params[:email]
    @app.app_icon = params["app"][:app_icon]
    if @app.save
           
      if params[:categories]

      params[:categories].each do |category|
          if !(Appcategory.exists?(:app_id => @app.id) and Appcategory.exists?(:category_name => category))

                     @app_cateogry = Appcategory.new
                     @app_cateogry.app_id = @app.id
                     @app_cateogry.category_name = category
                     @app_cateogry.save
          end   
     
       end #params[:categories].each ends

     end  #if params[:categories] ends

      flash[:notice] = 'Successfully create app'
    
    
    else
          flash[:notice] = 'Some error ocured'
    end

    redirect_to root_path
    

  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app.destroy
    respond_to do |format|
      format.html { redirect_to apps_url, notice: 'App was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def analytics
  end  

  def customize
    @app = App.find_by(:author_id =>current_author.id)
  end

  def faq
  end  

  def monetize
    @apps=App.where(author_id: current_author.id)
  end

  def get_monetize
    @app_id = App.find_by(app_name: params["app_name"]).id
    @new_monetize=Monetize.new(platform: params["platform"],phone_ad_unit: params["phone_ad_unit"],add_unit_id: params["add_unit_id"],interval: params["interval"],app_id: @app_id)
    @new_monetize.save
    redirect_to root_path
    # byebug
  end

  def push_notification
  end

  def all_notification
  end

  

  def support
    
  end

  # check if url is a wordpress blog: returns true for wordpress blog
  def check_site
    app_url = 'http://builtwith.com/' + @app.app_url
    @response = Nokogiri::HTML(open(app_url))
    @data= false
    @response.css('.techItem a').each do |link|
      if link.content == "WordPress"
        @data = true
      end
    end
  end
   
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
    @app = App.find_by(:author_id =>current_author.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:app_icon, :app_name,:app_url,:author_id,:contact_email)
    end

end
