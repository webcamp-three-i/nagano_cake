class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer
  
  def new
    @order = Order.new
    @shipping_addresses = ShippingAddress.where(customer: current_customer) #配送先モデルからログイン会員を取得して定義
  end

  def confirm #注文確認画面
    @order = Order.new
    
    #ラジオボタンで選択した注文の支払方法を、オーダーidカラムと支払方法カラムをparamsで受け取る
    @order.payment_method = params[:order][:payment_method]
    #ラジオボタンで選択したお届け先を、オーダーidとviewで作った:addプロパティをparamsで受け取る
    @add = params[:order][:add].to_i
    case @add
      when 1
        @order.postal_code = @customer.postal_code
        @order.address = @customer.residence
        @order.name = @customer.first_name + @customer.last_name
      when 2
        @sta = params[:order][:address].to_i
        @address = ShippingAddress.find(@sta)
        @order.postal_code = @address.postal_code
        @order.address = @address.residence
        @order.name = @address.name
      when 3
        @order.postal_code = params[:order][:new_add][:postal_code]
        @order.address = params[:order][:new_add][:address]
        @order.name = params[:order][:new_add][:name]
    end
    #この下から請求金額の変数定義
    @cart_items = current_customer.cart_items
    @sum = 0
    @cart_items.each do |cart_item|
    @sum += cart_item.product.price_without_tax * 1.10 * cart_item.quantity #商品の税込合計金額
    
    end
    @order.billing_amount = @sum + @order.postage.to_i #商品の税込金額に送料を足して請求金額を定義
    #binding.pry
  end


  def create #注文確定
    if current_customer.cart_items.exists? #if分で会員のカート内に商品が存在すればの分岐
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id #paramsでidは受け取れないのでここで定義
      
      @add = params[:order][:add].to_i #form_withで送られてきたモデルと住所のカラムをto_iで数字に変えて@addに定義
      case @add #上記定義で数字が1,2,3の場合で条件分岐
        when 1 #ご自身の住所の場合
          @order.postal_code = @customer.post_code
          @order.residence = @customer.address
          @order.name = @customer.first_name + @customer.last_name
        when 2 #登録済み住所から選択の場合
          @order.post_code = params[:order][:postal_code] #form_withで送られてきたモデルとカラムを受け取る
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
        when 3 #新しいお届け先の場合
          @order.post_code = params[:order][:post_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
      end
      @order.save

      # addressで住所モデル検索、該当データなければ新規作成
      if ShippingAddress.find_by(residence: @order.address).nil? #配送先モデルの住所が空であれば
        @address = ShippingAddress.new
        @address.postal_code = @order.postal_code
        @address.residence = @order.address
        @address.name = @order.name
        @address.customer_id = current_customer.id
        @address.save
      end

      # cart_itemsの内容をorder_productsに新規登録
      current_customer.cart_items.each do |cart_item|
        order_products = @order.order_products.build
        order_products.order_id = @order.id
        order_products.product_id = cart_item.product_id
        order_products.quantity = cart_item.quantity
        order_products.tax_included_price = cart_item.product.price_without_tax
        order_products.save
        cart_item.destroy #order_productにカート内の情報を移したらcart_itemを消去してthanksページに遷移
      end
      render :thanks
    else
      redirect_to root_path
      flash[:danger] = "カートが空です。"
    end
  end

  def thanks

  end

  def index
    @orders = @customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def set_customer
    @customer = current_customer
  end

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :billing_amount)
  end

end
