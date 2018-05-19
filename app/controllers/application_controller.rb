class ApplicationController < ActionController::Base
##  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
##  before_action :profibit_direct_link,only: [:edit, :show]
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end
  
  def after_update_path_for(resource)
    user_path(current_user.id)
  end
  
  def after_inactive_sign_up_path_for(resource)
    user_path(current_user.id)
  end
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
##  def profibit_direct_link
##    if Rails.application.routes.recognize_path(request.referrer) ==nil
##    redirect_to user_path
##    end
##  end
end