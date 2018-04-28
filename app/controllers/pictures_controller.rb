class PicturesController < ApplicationController
  before_action :set_picture,only: [:show, :edit, :update,:destroy]
  before_action :require_login,only: [:new, :edit, :show]
  
  def index
    @pictures = Picture.all
  end
  
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end
  
  def show
    @picture = Picture.find(params[:id])
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    @favorites = Favorite.where("user_id = ?", @user)
     
  end
  
  def create
    @picture = Picture.new(picture_params)
    @user_id = current_user.id
    @picture.user_id = current_user.id
    @favorite = Favorite.new(picture_id: @picture_id, user_id: @user_id)
  　@picture.image.retrieve_from_cache! params[:cache][:image] if params[:cache][:image].present?
        respond_to do |format|
    ##binding.pry
    if @picture.save
        MailerMailer.create_picture(@picture).deliver_later
        
        format.html { redirect_to(pictures_path, notice: '正常に投稿されました！') }
        format.json { render json: @picture, status: :created, location: @picture }
    else
        format.html { render action: 'new' }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
    end
    end
  end
  
  def edit
    @picture = Picture.find(params[:id])
  end
  
  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path,notice:"内容を編集しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"ブログを削除しました！"
  end
  
  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
   　render 'new' if @picture.invalid?
  end
  
  
  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to sessions_new_path # halts request cycle
    end
  end
 
  def picture_params
    params.require(:picture).permit(:title,:content,:image,:image_cache)
  end
  
  def set_picture
    @picture = Picture.find(params[:id])
  end
end
