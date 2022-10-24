class Public::OrderDetailsController < ApplicationController
  def update
    @order = Order.find(params[:order_id])
    @order_detail = @order.order_details.find(params[:id])
    if @order_detail.update(order_detail_params) && @order_detail.in_production?
      @order.in_production!
    elsif @order.are_all_details_completed?
        @order.preparing!
        # in_production preparingはmaking_statusのenum設定したもの。
    end
      redirect_to orders_path
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end