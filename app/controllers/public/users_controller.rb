class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user, except: [:profile, :follows, :followers]

  def show
    @works = @user.works.page(params[:page]).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def profile
    @user = User.find(params[:id])
    @following_users = @user.following_user
    @follower_users = @user.follower_user
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

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:work_id)
    @favorite_works = Work.find(favorites)
  end

  def destroy_user #ゲストユーザー用
    @user = current_user
    if @user.email == 'guestda@example.com'
      reset_session
      redirect_to :root
    else
      @user.update(is_valid: false)
      reset_session
      redirect_to :root
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:profile_image, :user_name, :email, :telephone_number, :bio, :is_editor, :is_deleted)
  end
end
