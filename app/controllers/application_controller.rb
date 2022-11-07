class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url
  before_action :configure_permitted_parameters, if: :devise_controller?


  def admin_url
    request.fullpath.include?("/admin")
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :telephone_number])
  end
end
