class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end

# class ApplicationController < ActionController::Base
#   protect_from_forgery with: :exception

#   before_action :authenticate_user!, :update_allowed_parameters, if: :devise_controller?

#   protected

#   def update_allowed_parameters
#     devise_parameter_sanitizer.permit(:sign_up) { |user| user.permit(:username, :email, :password) }
#     devise_parameter_sanitizer.permit(:account_update) do |user|
#       user.permit(:name, :email, :password, :current_password, :avatar)
#     end
#   end

# end
