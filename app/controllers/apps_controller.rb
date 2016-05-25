class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_author!
<<<<<<< HEAD
  before_create :generate_access_token
=======
  
>>>>>>> development
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
    @app = App.new

  end

  # GET /apps/1/edit
  def edit
  end

  # POST /apps
  # POST /apps.json
  def create
    @app = App.new
    
   
     @app.author_id     =   params[:app][:author_id]
     @app.app_name      =   params[:app_name]
     @app.app_url       =   params[:app][:app_url]
     @app.app_icon      =   params[:app][:app_icon] 
     @app.contact_email =   params[:app][:contact_email]

    if @app.save

          flash[:notice] = 'Successfully create app'
    else
          flash[:notice] = 'Some error ocured'
    end

     redirect_to root_path
    

    

    
      end

  # PATCH/PUT /apps/1
  # PATCH/PUT /apps/1.json
  def update
    respond_to do |format|
      if @app.update(app_params)
        format.html { redirect_to @app, notice: 'App was successfully updated.' }
        format.json { render :show, status: :ok, location: @app }
      else
        format.html { render :edit }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
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

  def posts
  end

  def push_notification
  end

  def all_notification
  end

  def customize
  end

  def support
  end
   
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:app_icon, :app_name,:app_url,:author_id,:contact_email)
    end

<<<<<<< HEAD
    def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
=======

>>>>>>> development
end
