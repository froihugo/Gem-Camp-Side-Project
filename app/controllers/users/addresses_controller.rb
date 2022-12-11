class Users::AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_user_address_owner
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @addresses = current_user.addresses.includes(:user, :region, :province, :city, :barangay)
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.user = current_user
    if @address.save
      flash[:notice] = "Address was created successfully."
      redirect_to address_book_path(current_user.username)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    @address.update(address_params)
    @address.user = current_user
    if @address.save
      flash[:notice] = "Address was updated successfully."
      redirect_to address_book_path(current_user.username)
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    flash[:notice] = "Address was deleted successfully."
    redirect_to address_book_path(current_user.username)
  end

  private

  def address_params
    params.require(:address).permit(:name, :genre, :street_address, :phone_number, :is_default, :remark, :address_region_id, :address_province_id, :address_city_id, :address_barangay_id)
  end

  def set_user
    @user = current_user
  end

  def set_address
    @address = current_user.addresses.find_by(params[:id])
  end

  def validate_user_address_owner
    unless @user = current_user
      flash[:notice] = 'ERROR'
      redirect_to users_addresses_path
    end
  end
end