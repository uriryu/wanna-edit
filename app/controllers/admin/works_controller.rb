class Admin::WorksController < ApplicationController
  before_action :ensure_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
    @all_works_count = @works.count
    @user = User.find_by(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def destroy
    @work.delete
    redirect_to admin_user_path
  end
  # updateをかく

  private

  def work_params
    params.require(:work).permit(:image, :title, :body, :url)
  end

  def ensure_work
    @work = Work.find(params[:id])
  end
end
