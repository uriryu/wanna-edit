class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_order, only: [:show, :update]

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @orders = @user.orders.page(params[:page]).reverse_order
    elsif params[:created_at] == "today"
      @orders = Order.ordered_today.includes(:user).page(params[:page]).reverse_order
    else
      @orders = Order.includes(:user).page(params[:page]).reverse_order
    end
  end

  def show
    @order_details = @order.order_details.includes(:skill)
    @user = @order.user
  end

  def update
    if @order.update(order_params) && @order.confirm_deposit?
      @order.order_details.update_all(making_status: 1)
    end
    redirect_to admin_order_path(@order)
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

  def ensure_order
    @order = Order.find(params[:id])
  end
end
