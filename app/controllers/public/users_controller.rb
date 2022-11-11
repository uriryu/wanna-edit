class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:profile]
  before_action :set_current_user, except: [:profile, :follows, :followers]

  def show
    @works = @user.works.page(params[:page]).per(4).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user

    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_skills = @genre.skills.page(params[:page]).per(5)
    else
      all_skills = Skill.includes(:genres)
    end
    @skills = all_skills.page(params[:page]).per(5)
    @all_skills_count = all_skills.count
  end

  def profile
    @user = User.find(params[:id])
    @skills = @user.skills
    @following_users = @user.following_user
    @follower_users = @user.follower_user

  if user_signed_in?
    # DM機能
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end
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
    @user.skills.update(is_active: false)
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
