class Admin::UsersController < ApplicationController
  before_action :authenticate_admin

  def index
    @users = User.where(role: 0)
  end

  private

  def authenticate_admin
    raise ActionController::RoutingError.new('Not Found') unless current_admins_user
  end
end