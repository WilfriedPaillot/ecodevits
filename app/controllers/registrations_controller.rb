class RegistrationsController < Devise::RegistrationsController

  protected
  
  def update_resource(resource, params)
    puts "params ===> #{params}"
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
      params.delete(:current_password)
      resource.update_without_password(params)
    else
      super
    end
  end

end