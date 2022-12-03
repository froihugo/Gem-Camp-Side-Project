class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
    end
          
    def user_params
        params.require(:user).permit(:avatar, :phone, :username, :email)
    end
end