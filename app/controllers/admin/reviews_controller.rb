class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_review, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def ensure_review
    @review = Review.find(params[:id])
  end
end
