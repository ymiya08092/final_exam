class BlogsController < ApplicationController
  before_action :set_blog,only: [:show, :edit, :update,:destroy]
  before_action :require_login,only: [:new, :edit, :show]
  
  def index
    @blogs = Blog.all
  end
  
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end
  
  def show
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
##    @user = User.find(params[:id])
    @favorites = Favorite.where("user_id = ?", @user)
     
  end
  
  def create
    @blog = Blog.new(blog_params)
    @user_id = current_user.id
    @blog.user_id = current_user.id
    @favorite = Favorite.new(blog_id: @blog_id, user_id: @user_id)
    ##if blog_params[:image].present?
    @blog.image.retrieve_from_cache! params[:cache][:image]
    respond_to do |format|
    if @blog.save
    ##  redirect_to blogs_path, notice: 'ブログを作成しました！.' 
    ##  else
    ##  render 'new'
    ##end
       MailerMailer.create_blog(@blog).deliver_later
        
        format.html { redirect_to(blogs_path, notice: 'ブログが正常に作成されました。') }
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: 'new' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
    end
  end
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path,notice:"ブログを編集しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end
  
  def confirm
    @blog = Blog.new(blog_params)
  end
  
  
  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_path # halts request cycle
    end
  end
 
  def blog_params
    params.require(:blog).permit(:title,:content,:image,:cache)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
  
end
