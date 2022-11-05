class Public::WorksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_action :ensure_work, only: [:show, :edit, :update, :destroy]
  def new
    @work = Work.new
  end

  def edit
  end

  def index
    @works = Work.all
  end

  def show
    @review = Review.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
    else
      @works = Work.all
      render :new
    end
  end

  def update
    @work.update(work_params) ? (redirect_to work_path(@work)) : (render :edit)
  end

  def destroy
    @work.destroy
    redirect_to works_path
  end

  private

  def work_params
    params.require(:work).permit(:title, :body, :url, :image, :user_id, :work_id, :review_id, :reputation)
  end

  def ensure_work
    @work = Work.find(params[:id])
  end
end
