class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]
  # protect_from_forgery 
  layout "step-form", only: [:customize]
  before_filter :authenticate_author! ,:except => [:customize,:update, :save_draft,:emulator]
  include CategoryHelper
  include PageHelper

  # GET /apps
  # GET /apps.json
  def index
    @apps = OrderState.where(author_id: current_author.id)
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
  end

  def file_maker
      require 'json'

      @author = Author.find(1).id

      path = "/home/rajiv/#{@author}.json"

      content = Author.find(1).email
      File.open(path, "w+") do |f|
        f.write(content.to_json)

      end
       redirect_to root_path
  end


  # GET /apps/new
  def new
    end

  # GET /apps/1/edit
  def edit
    @app = App.find_by(:author_id =>current_author.id)
    @app_draft = AppDraft.find_by(app_id: @app.id,author_id: @app.author_id)
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
    if current_author
      $current_author = current_author
    end
    @app = App.find_by(:author_id =>$current_author.id)
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

    @final_draft = AppDraft.find_by(app_id: @app.id,author_id: @app.author_id)
    if not @final_draft.nil?
      @final_draft.destroy
    end

      flash[:notice] = 'Successfully create app'
      
    
    else
          flash[:notice] = 'Some error ocured'
    end

    if not current_author
      redirect_to payments_path
    else 
      @app_order = OrderState.new()
      @app_order.update(app_version_name: @app.app_name,app_status: "pending",generated_date: Date.today,author_id: current_author.id )
      redirect_to root_path
    end

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
    @app=App.find_by(author_id: current_author.id)
    @analytics=@app.google_analytic
  end  

  def get_analytics
    @app=App.find_by(author_id: current_author.id)
    if @app.google_analytic.nil?
      @new_analytic=GoogleAnalytic.new(analytics_id: params["analytics_id"], app_id: @app.id)    
      @new_analytic.save
    else  
      @analytics=@app.google_analytic
      @analytics.update(analytics_id: params["analytics_id"])
    end  
    redirect_to root_path
  end  

  def customize
    @app = App.find_by(:author_id =>$current_author.id)
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
    @monetize=@apps.monetize
  end

  def get_monetize
    @app= App.find_by(app_name: params["app_name"])
    if @app.monetize.nil?
      @new_monetize=Monetize.new(platform: params["platform"],phone_ad_unit: params["phone_ad_unit"],add_unit_id: params["add_unit_id"],interval: params["interval"],app_id: @app.id)
      @new_monetize.save
    else
      @monetize=@app.monetize
      @monetize.update(platform: params["platform"],phone_ad_unit: params["phone_ad_unit"],add_unit_id: params["add_unit_id"],interval: params["interval"])
    end    
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
      @draft = AppDraft.new(app_id: params[:app_id], author_id: params[:author_id],app_icon: params["file_path"], app_name: params["app[app_name]"],about_us: params["app[about_us]"], accent_colour: params["app[appcolour_attributes][accent_colour]"], article_colour: params["app[appcolour_attributes][article_colour]"], article_writer_colour: params["app[appcolour_attributes][article_writer_colour]"], brand_colour: params["app[appcolour_attributes][brand_colour]"], top_bar_colour: params["app[appcolour_attributes][top_bar_colour]"], privacy_policy: params["app[privacy_policy]"], contact_email: params["app[contact_email]"],categories: params["app[appcategory][categories][]"] )
        @draft.save   
        respond_to do |format|
          format.json{
            render :json => {:status => :ok,:message => "Success!"}.to_json
          }
        end  
    else
      @old_draft.update(app_id: params[:app_id], author_id: params[:author_id],app_icon: params["file_path"], app_name: params["app[app_name]"],about_us: params["app[about_us]"], accent_colour: params["app[appcolour_attributes][accent_colour]"], article_colour: params["app[appcolour_attributes][article_colour]"], article_writer_colour: params["app[appcolour_attributes][article_writer_colour]"], brand_colour: params["app[appcolour_attributes][brand_colour]"], top_bar_colour: params["app[appcolour_attributes][top_bar_colour]"], privacy_policy: params["app[privacy_policy]"], contact_email: params["app[contact_email]"],categories: params["app[appcategory][categories][]"]  )
    end
  end 

  def emulator
    @urlstring_to_post = 'https://tok_fyq9wgjq8ep7yc7h1nkwy6xy8w@api.appetize.io/v1/apps'
    @result = HTTParty.post(@urlstring_to_post.to_str,:body => { :file => '@app-release.apk', :platform => 'android'}.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
    respond_to do |format|
          format.json{
            render :json => {:status => :ok,:message => "Success!"}.to_json
          }
        end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      if current_author
        @app = App.find_by(:author_id =>current_author.id)
      else
        @app = App.find_by(:author_id =>$current_author.id)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:app_icon,:app_icon_cache, :app_name,:app_url,:author_id,:contact_email,:about_us,:privacy_policy, :appcolour_attributes => [:id,:app_id,:top_bar_colour, :brand_colour, :accent_colour, :article_colour, :article_writer_colour])
    end

end
