class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user
  
  def show
    @works = current_user.works
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: '会員情報が更新されました。'
    else
      render :edit
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  private
  
  def set_ current_user
    @user = current_user
  end
  
  def user_params
    params.require(:user).permit(:profile_image, :user_name, :email, :telephone_number, :bio, :is_editor, :is_deleted)
  end
end
