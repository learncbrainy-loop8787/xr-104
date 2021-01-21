class SessionsController < ApplicationController
    skip_before_action :require_login
    
    def new
        redirect_to user_path(current_user) if current_user
        @user = User.new
    end

    def create
        if auth_hash = auth
            @user = User.find_or_create_by_omniauth(auth_hash)
            session[:user_id] = @user.id
            flash["alert alert-success"] = "You're in!"
            redirect_to user_path @user
        else
            @user = User.find_by(email: params[:email])
            if @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id
                flash["alert alert-success"] = "You're in!"
                redirect_to user_path @user
            else 
                flash["alert alert-danger"] = "Must be a hacker invalid solldier."
                render :new
            end
        end
    end

    def destroy
        session.clear unless session[:user_id].nil?
        flash["alert alert-danger"] = "You've logged out."
        redirect_to login_path
    end

    private
 
    def auth
        request.env['omniauth.auth']
    end

end
  