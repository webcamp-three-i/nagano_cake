class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_product = OrderProduct.find(params[:id])
    if @order_product.update(order_product_params)
      if @order_product.production_status == "制作中"
        @order_product.order.update(order_status: "制作中")
      elsif @order_product.production_status == "制作完了"
        count = 0
        @order_product.order.order_products.each do |order_product|
          if order_product.production_status == "制作完了"
            count += 1
          else 
            break
          end
         end
        if @order_product.order.order_products.size == count
          @order_product.order.update(order_status: "発送準備中")
        end
      end
      redirect_to admin_order_path(@order_product.order)
      flash[:notice] = "制作ステータスを変更しました"
    else
      render :show
    end

  end

  private
  
  def order_product_params
    params.require(:order_product).permit(:production_status)
  end

end
