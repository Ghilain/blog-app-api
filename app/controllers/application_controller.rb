class ApplicationController < ActionController::Base
  respond_to :json, :html

  protect_from_forgery unless: -> { request.format.json? }

  before_action :authenticate_user!
  before_action :change_default_field, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_back fallback_location: root_path, notice: exception.message }
      format.js { head :forbidden, content_type: 'text/html' }
    end
  end

  protected

  def change_default_field
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :photo, :bio, :email, :password) }
  end
end
