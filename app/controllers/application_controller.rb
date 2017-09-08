class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:edit, keys: [:username, :email, :password, :current_password, :admin, :about])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :about])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :current_password, :admin, :about])
  end
end
