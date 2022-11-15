class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :ensure_review, only: [:edit, :update]
  before_action :ensure_user, only: [:edit, :update]

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to work_reviews_path(@review.work), notice: "You have created review successfully."
    else
      @work = Work.find(parmas[:id])
      render "works/show"
    end
  end

  def index
    @work = Work.find(params[:work_id])
    @review = Review.find_by(params[:review_id])
    @reviews = @work.reviews
  end

  def edit
  end

  def update
    @work = Work.find(params[:work_id])
    @review.update(review_params) ? (redirect_to work_reviews_path(@work.id)) : (render :edit)
  end

  def destroy
    @work = Work.find(params[:work_id])
    work_review = @work.reviews.find(params[:id])
    if work_review.user != current_user
      redirect_to request.referer
    end
    work_review.destroy
    redirect_to work_reviews_path
  end

  private
  def review_params
    params.require(:review).permit(:work_id, :review_id, :reputation, :body)
  end

  def ensure_review
    @review = Review.find(params[:id])
  end

  def ensure_user
    @review = Review.find(params[:id])
    if @review.user.id != current_user.id
      flash[:alert] = "権限がありません"
      redirect_to works_path
    end
  end
end
