class Public::WorksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_work, only: [:show, :edit, :update]
  def new
    @work = Work.new
  end

  def edit
  end

  def index

  end

  def show
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
    else
      @works = Work.all
      render :index
    end
  end

  def update
    @work.update(work_params) ? (redirect_to work_path(@work)) : (render :edit)
  end

  def destroy
    @work.delete
    redirect_to admin_user_path
  end

  private

  def work_params
    params.require(:work).permit(:title, :body, :url, :image, :user_id)
  end

  def ensure_work
    @work = Work.find(params[:id])
  end
end
