class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
    @sum_product = 0
    @order_products.each do |order_product|
    @sum_product += order_product.tax_included_price * 1.10 * order_product.quantity
    end
    @sum_all = @sum_product.floor + @order.postage 
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path(@order)
      flash[:notice] = "注文ステータスを変更しました"
    else
      render :show
    end
  end

  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
end
