class ApplicationController < ActionController::Base
    protect_from_forgery
    helper_method :current_user, :signed_in?, :is_admin?

    def current_user
        if session[:user_id]
            @current_user ||= User.find(session[:user_id])
        else
            @current_user = nil
        end
    end

    def signed_in?
        !!current_user
    end

    def is_admin?
        signed_in? ? current_user.role == 'admin' : false
    end
end
