class PlacesController < ApplicationController
  before_action :set_place,only: [:show, :edit, :update,:destroy]
  before_action :authenticate_user!,only: [:index,:new, :edit, :show]
  
  
  def index
    @places = current_user.places.all
    respond_to do |f|
      f.html
      f.json { render json: @places }
    end
    if params[:category].present? 
      @places = @places.get_by_category params[:category]
    end
  end
  
  def new
    if params[:back]
      @place = Place.new(place_params)
    else
      @place = Place.new
    end
  end
  
  def show
    @place = Place.find(params[:id])
##    @favorite = current_user.favorites.find_by(place_id: @place.id)
##    @favorites = Favorite.where("user_id = ?", @user)
     
  end
  
  def create
    @place = Place.new(place_params)
    @user_id = current_user.id
    @place.user_id = current_user.id
    render :new if @place.invalid?
    if params[:back]
      render :new
    elsif @place.save
        redirect_to place_path(@place.id), notice: 'Your note has been created successfully.！'
    else
        render :new
    end
  end
  
  def edit
    @place = Place.find(params[:id])
  end
  
  def update
    @place = Place.find(params[:id])
   if params[:back]
##      @place = Place.new(place_params)
     @place = Place.new(place_params)  
     render:edit
##       redirect_to edit_place_path(@place.id)
    elsif @place.update(place_params)
      redirect_to place_path(@place.id), notice: 'Your note has been updated successfully.！'
    end
  end
  
  def destroy
    @place.destroy
    redirect_to places_path, notice:"ブログを削除しました！"
  end
  
  def confirm
    @place = Place.new(place_params)    
    @place.user_id = current_user.id
    if @place.valid?
      render :action => 'confirm'
    else
      render :new
    end
  end
  
  def confirm_edit
    @place = Place.new(place_params)   
    @place.user_id = current_user.id
    if @place.valid?
      render :action => 'confirm_edit'
    else
      render :edit
    end
  end
  
  
  
  
  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path # halts request cycle
    end
  end
 
  def place_params
    params.require(:place).permit(:title,:description,:address,:latitude,:longitude,:category,:place,:id)
  end
  
  def set_place
    @place = Place.find(params[:id])
  end
end