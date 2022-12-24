class UsersController < ApplicationController
    def show
        @user = User.find_by_username(params[:username]) && current_user
    end
end