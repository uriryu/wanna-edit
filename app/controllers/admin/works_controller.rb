class Admin::WorksController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_work, only: [:edit, :update, :destroy]

  def index
    @works = Work.all
    @all_works_count = @works.count
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  private

  def work_params
    params.require(:work).permit(:image, :title, :body, :url)
  end

  def ensure_work
    @work = Work.find(params[:id])
  end
end
