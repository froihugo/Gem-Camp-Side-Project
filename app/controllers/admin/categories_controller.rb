class Admin::CategoriesController < ApplicationController
    before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params_category)
    if @category.save
      flash[:notice] = "Create Successfully"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(params_category)
      flash[:notice] = "Updated Successfully"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "Deleted Successfully"
      redirect_to admin_categories_path
    else
      flash[:alert] = "Error"
      redirect_to admin_categories_path
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def params_category
    params.require(:category).permit(:name)
  end
end
