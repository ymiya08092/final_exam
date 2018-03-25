class UsersController < ApplicationController
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
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end