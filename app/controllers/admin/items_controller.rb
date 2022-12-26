class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session

  def index
    @items = Item.includes(:categories)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Item sucessfully added!"
      redirect_to admin_items_path
    else
      render :new, status: :unprocessable_entity
    end

  end

  def show; end

  def edit; end

  def update
    @item.update(item_params)
    if @item.save
      flash[:notice] = "Editted Successfully"
      redirect_to admin_items_path(item.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :quantity, :minimum_bets, :online_at, :offline_at, :start_at, :status, category_ids: [])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end