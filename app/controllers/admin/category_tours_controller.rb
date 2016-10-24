class Admin::CategoryToursController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :load_category_tour, only: [:edit, :update, :destroy]
  before_action :verify_admin

  def new
    @category_tour = CategoryTour.new
  end

  def create
    @category_tour = CategoryTour.new category_tour_params
    if @category_tour.save
      flash[:success] = t "category.message_success"
      redirect_to admin_category_tours_path
    else
      render :new
    end
  end

  def index
    @category_tours = CategoryTour.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @category_tour.update_attributes category_tour_params
      flash[:success] = t "category.message_success"
      redirect_to admin_category_tours_path
    else
      flash[:danger] = t "category.message_failed"
      render :edit
    end
  end

  def destroy
    if @category_tour.destroy
      flash[:success] = t "category.destroy_message"
    else
      flash[:danger] = t "category.destroy_error"
    end
      redirect_to admin_category_tours_path
  end

  private
  def load_category_tour
    @category_tour = CategoryTour.find_by id: params[:id]
    unless @category_tour
      flash[:danger] = t "not_found"
      redirect_to admin_category_tours_path
    end
  end

  def category_tour_params
    params.require(:category_tour).permit :title
  end
end
