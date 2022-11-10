class Public::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_cart_items, only: [:new, :confirm, :create, :error]

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
  end

  def error
  end

  def create
    @order = current_user.orders.new(order_params)
    @order.total_payment = @cart_items.sum(&:subtotal)
    if @order.save
      @order.create_order_details(current_user)
      redirect_to thanks_path
    else
      render :new
    end
  end

  def thanks
  end

  def index
  
    @order = Order.find_by(params[:order_id])
    @order_details = @order.order_details.includes(:skill)
    if params[:user_id]
      @user = User.find(params[:user_id])
      @orders = @user.orders.page(params[:page]).reverse_order
    elsif params[:created_at] == "today"
      @orders = Order.ordered_today.includes(:user).page(params[:page]).reverse_order
    else
      #@orders = current_user.orders.includes(:order_details, :skills).page(params[:page]).reverse_order
      #@orders = Order.includes(:user).page(params[:page]).reverse_order
      
      @target_skill_ids = current_user.skills.ids
      @target_order_ids = OrderDetail.select(:order_id).where(skill_id: @target_skill_ids)
      @orders = Order.where(id: @target_order_ids).page(params[:page]).reverse_order
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
    @order_detail = @order.order_details.includes(:skill)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params) && @order.confirm_deposit?
      @order.order_details.update(making_status: 1)
    end
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:name, :payment_method, :deadline, :status)
  end

  def ensure_cart_items
    @cart_items = current_user.cart_items.includes(:skill)
    redirect_to skills_path unless @cart_items.first
  end
end
