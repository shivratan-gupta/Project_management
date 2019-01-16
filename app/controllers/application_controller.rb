class ApplicationController < ActionController::Base
	before_action :authenticate_user!
 	before_action :configure_permitted_parameters, if: :devise_controller?
 	before_action :check_user_role
	def current_ability
	  @current_ability ||= Ability.new(current_user)
	end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:full_name,:role])
  end

  def check_user_role
  	if current_user.present?
	    user_role = UserRole.find_by(:user_id => current_user.id)
	    if user_role.present?
	   		session[:user_role] = UserRole::ROLES[user_role.role_id]
	    else
	    	session[:user_role] = ''
	    end
	end
  end
end
