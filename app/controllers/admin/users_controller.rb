class Admin::UsersController < ApplicationController
    def index
        @users = User.where(role: 'user')
    end

    def show
        @user = set_user
    end
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end
end
