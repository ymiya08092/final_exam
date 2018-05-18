class UsersController < ApplicationController
  before_action :confirm_image,only: [:update]
  before_action :configure_permitted_parameters, if: :devise_controller?
   protect_from_forgery :except => [:create]
   
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
     respond_to do |format|
    if @user.save
      MailerMailer.create_user(@user).deliver_later
       ## redirect_to user_path(@user.id)
        format.html { redirect_to(@user, notice: 'ユーザーが正常に作成されました。') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
   @user = User.find(params[:id])
##   rescue ActiveRecord::InvalidError => e
##   binding.pry
   if @user.update(user_params)
      redirect_to user_path, notice: '画像をアップロードしました。'
   else
      render edit
   end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to '/'
  end
  
  def favorites
    @user = User.find(params[:id])
    @favorites = Favorite.all
    @picture = Picture.all
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :image,
                                 :password_confirmation)
  end
  

end