
class ApplicationController < ActionController::Base
 before_action :require_login
 helper_method :logged_in?, :current_user
    private

    def logged_in?
     !!current_user
    end

    def current_user
        if session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def require_login
       
        unless logged_in?
        flash["alert alert-success"] = "Logged in!."
        redirect_to login_path
        end
    end

    def require_general
     
        unless current_user.try(:general)
            flash["alert alert-danger"] = "Access denied!"
            redirect_to soldiers_path
        end
    end
end
