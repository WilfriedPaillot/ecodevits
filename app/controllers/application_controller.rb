class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :danger, :info, :warning, :success, :messages
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # Devise overrides
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :username, :first_name, :last_name, :adress, :zipcode, :city, specialities: []])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role, :approved, :username, :first_name, :last_name, :adress, :zipcode, :city, specialities: []])	
  end
end
