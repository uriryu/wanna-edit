class Public::WorksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_work, only: [:show, :edit, :update]
  def show
  end

  def edit
  end

  def index
    @work = Work.new
    @user = User.find_by(params[:user_id])
    #find_byでURLに:idがなくても、欲しいデータを取れるようにした。※要確認
    @works = @user.works.all
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

  private

  def work_params
    params.require(:work).permit(:title, :body, :url, :image, :user_id)
  end

  def ensure_work
    @work = Work.find(params[:id])
  end
end
