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
    @orders = current_user.orders.includes(:order_details, :skills).page(params[:page]).reverse_order
  end

  def show
    @order = current_user.orders.find(params[:id])
    @order_details = @order.order_details.includes(:skill)
  end

  private

  def order_params
    params.require(:order).permit(:name, :payment_method, :deadline)
  end

  def ensure_cart_items
    @cart_items = current_user.cart_items.includes(:skill)
    redirect_to skills_path unless @cart_items.first
  end
end
