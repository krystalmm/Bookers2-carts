class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top,:about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admins_homes_top_path
    when User
     user_path(current_user.id)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
    :email,
    :name,
    :postcode,
    :prefecture_code,
    :address_city,
    :address_street,
    ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
