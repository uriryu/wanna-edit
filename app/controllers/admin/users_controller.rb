class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_user, only: [:show, :edit, :update]

  def index
    @users = User.all
    # あとでpagenateを使うこと。
  end

  def show
  end

  def edit
  end

  private

  def ensure_user
    @user = User.find(params[:id])
  end
end
