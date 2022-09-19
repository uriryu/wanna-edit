class Admin::WorksController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_work, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find(params[:id])
    all_works = @user.works
    @works = all_works
    @all_works_count = all_works.count
  end

  def show
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
