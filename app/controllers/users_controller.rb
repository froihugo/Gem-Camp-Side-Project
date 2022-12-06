class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:show]

    def show
        @user = current_user
        @user = User.find_by_username(params[:username])
    end
          
    def user_params
        params.require(:user).permit(:avatar, :phone, :username, :email)
    end
end