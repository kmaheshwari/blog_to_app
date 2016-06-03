class AppcoloursController < ApplicationController
	before_action :set_appcolour, only: [:show, :edit, :update, :destroy]


  def index
    @appcolours = Appcolour.all
  end

  def show
  end

  def new
    @appcolour = Appcolour.new
  end

  def edit
  end

  def create
    @appcolour = Appcolour.new(appcolour_params)

    respond_to do |format|
      if @appcolour.save
        format.html { redirect_to @appcolour, notice: 'Appcolour was successfully created.' }
        format.json { render action: 'show', status: :created, location: @appcolour }
      else
        format.html { render action: 'new' }
        format.json { render json: @appcolour.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @appcolour.update(appcolour_params)
        format.html { redirect_to @appcolour, notice: 'Appcolour was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @appcolour.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @appcolour.destroy
    respond_to do |format|
      format.html { redirect_to appcolours_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appcolour
      @appcolour = Appcolour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appcolour_params
      params.require(:appcolour).permit(:id, :app_id, :top_bar_colour, :brand_colour, :accent_colour, :article_colour, :article_writer_colour)
    end
end
