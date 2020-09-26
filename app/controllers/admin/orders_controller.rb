class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def index
    # 遷移元のリンクページに持たせたパラメーターを変数で振り分ける
    # 管理者側トップページから遷移する本日の注文一覧
    if params[:order_sort] == "0"
      @orders = Order.where(created_at: Time.zone.now.all_day).page(params[:page]).per(10)
      # 管理者側顧客詳細ページから遷移する該当顧客の注文一覧
    elsif params[:order_sort] == "1"
      # 顧客詳細ページの注文履歴のリンクにcustomer_id: @customer.idを持たせることで顧客と注文履歴を紐付ける
      @customer = Customer.find(params[:customer_id])
      @orders = @customer.orders.page(params[:page]).per(10)
      # ヘッダーから遷移する全顧客の注文一覧
    else
      @orders = Order.all.page(params[:page]).per(10)
    end
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
      if @order.order_status == "入金確認"
        @order.order_products.each do |order_product|
          order_product.update(production_status: "制作待ち")
        end
      end


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
