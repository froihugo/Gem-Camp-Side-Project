class HomeController < ApplicationController
  before_action :authenticate_users_user!, except: :index

  def index; end
end
