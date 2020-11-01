class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      # Redirect admin dashboard
      if user.role == 'admin'
        redirect_url = admin_users_url
      else
        redirect_url = home_page_url;
      end
      redirect_to redirect_url
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "Logged out!"
  end
end
