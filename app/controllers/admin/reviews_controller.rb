class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_review, only: [:edit, :update]

  def index
    @user = User.find(params[:user_id])
    @reviews = @user.reviews
  end

  def edit
  end

  def update
    @user = @review.user
    @review.update(review_params)
    redirect_to admin_user_reviews_path(user_id: @user.id)
  end

  def destroy
    @user = User.find(params[:user_id])
    user_review = @user.reviews.find(params[:id])
    user_review.destroy
    redirect_to admin_user_reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:work_id, :review_id, :reputation, :body, :check)
  end

  def ensure_review
    @review = Review.find(params[:id])
  end
end
