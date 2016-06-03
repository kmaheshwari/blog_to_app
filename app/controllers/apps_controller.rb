class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]
  # protect_from_forgery 
  layout "step-form", only: [:customize]
  before_filter :authenticate_author! 
  include CategoryHelper
  include PageHelper

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
    @app_draft = AppDraft.find_by(app_id: current_app.id,author_id: current_app.author_id)
    @category_data=populate @app.app_url
    @page_data=page_populate @app.app_url
    if @category_data.nil?
      @categories=nil
    else  
      @categories=@category_data
    end
    if @page_data.nil?
      @pages=nil
    else  
      @pages=@page_data
    end
  end

  # POST /apps
  # POST /apps.json
  def create
  end

  # PATCH/PUT /apps/1
  # PATCH/PUT /apps/1.json
  def update
    @app = App.find_by(:author_id =>current_author.id)
    @app.update(app_params)
    if params["app"][:app_icon]
      @app.app_icon = params["app"][:app_icon]
    end
    if @app.save
           
      if params[:categories]

      params[:categories].each do |category|
          if !(Appcategory.exists?(:app_id => @app.id) and Appcategory.exists?(:category_name => category))

             @app_category = Appcategory.new
             @app_category.app_id = @app.id
             @app_category.category_name = category
             @app_category.save
          end   
     
       end #params[:categories].each ends
     end

    @final_draft = AppDraft.find_by(app_id: current_app.id,author_id: current_app.author_id)
    if not @final_draft.nil?
      @final_draft.destroy
    end

      flash[:notice] = 'Successfully create app'
    
    
    else
          flash[:notice] = 'Some error ocured'
    end

    redirect_to payments_path
    

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
    @data=populate @app.app_url
    if @data.nil?
      @categories=nil
    else  
      @categories=@data
    end  
  end

  def faq
  end  

  def monetize
    @apps=App.find_by(author_id: current_author.id)
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
    begin
      @response = Nokogiri::HTML(open(app_url))
      @data= false
      @response.css('.techItem a').each do |link|
        if link.content == "WordPress"
          @data = true
        end
      end
    rescue
      flash[:alert] = "Enter a valid url"
    end
  end
  
  def save_draft
    @old_draft = AppDraft.find_by(app_id: params["app_id"],author_id: params["author_id"])
    if @old_draft.nil?
      @draft = AppDraft.new(app_id: params[:app_id], author_id: params[:author_id],app_icon: params["app[app_icon]"], app_name: params["app[app_name]"],about_us: params["app[about_us]"], accent_colour: params["app[appcolour_attributes][accent_colour]"], article_colour: params["app[appcolour_attributes][article_colour]"], article_writer_colour: params["app[appcolour_attributes][article_writer_colour]"], brand_colour: params["app[appcolour_attributes][brand_colour]"], top_bar_colour: params["app[appcolour_attributes][top_bar_colour]"], privacy_policy: params["app[privacy_policy]"], contact_email: params["app[contact_email]"],categories: params["app[appcategory][categories][]"] )
      @draft.save
    else
      @old_draft.update(app_id: params[:app_id], author_id: params[:author_id],app_icon: params["app[app_icon]"], app_name: params["app[app_name]"],about_us: params["app[about_us]"], accent_colour: params["app[appcolour_attributes][accent_colour]"], article_colour: params["app[appcolour_attributes][article_colour]"], article_writer_colour: params["app[appcolour_attributes][article_writer_colour]"], brand_colour: params["app[appcolour_attributes][brand_colour]"], top_bar_colour: params["app[appcolour_attributes][top_bar_colour]"], privacy_policy: params["app[privacy_policy]"], contact_email: params["app[contact_email]"],categories: params["app[appcategory][categories][]"]  )
    end
  end 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
    @app = App.find_by(:author_id =>current_author.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:app_icon,:app_icon_cache, :app_name,:app_url,:author_id,:contact_email,:about_us,:privacy_policy, :appcolour_attributes => [:id,:app_id,:top_bar_colour, :brand_colour, :accent_colour, :article_colour, :article_writer_colour])
    end

end
