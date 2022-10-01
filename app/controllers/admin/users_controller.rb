class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_user, only: [:show, :edit, :update]

  def index
    @users = User.all
    # あとでpagenateを使うこと。
  end

  def show
    @works = @user.works
    @all_works_count = @works.count
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path, notice: '会員情報を更新しました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :telephone_number, :email, :is_editor, :is_deleted)
  end

  def ensure_user
    @user = User.find(params[:id])
  end
end
