class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_work
  before_action :set_user, only: [:index]


  def create
    @favorite = current_user.favorites.new(work_id: params[:work_id])
    @favorite.save
  end

  def destroy
    @favorite = current_user.favorites.find_by(user_id: current_user.id, work_id: @work.id)
    @favorite.destroy
  end

  private

  def set_work
    @work = Work.find(params[:work_id])
  end
end
