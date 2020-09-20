class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer
  
  def new
    @order = Order.new
  end

  def confirm #注文確認画面
    @order = Order.new
    @cart_items = current_customer.cart_items
    #ラジオボタンで選択した注文の支払方法を、オーダーidカラムと支払方法カラムをparamsで受け取る
    @order.payment_method(params[:order][:payment_method]) 
    #ラジオボタンで選択したお届け先を、オーダーidとviewで作った:addプロパティをparamsで受け取る
    @add = params[:order][:add].to_i
    case @add
      when 1
        @order.postal_code = @customer.postal_code
        @order.address = @customer.address
        @order.name = @customer.first_name + @customer.last_name
      when 2
        @sta = params[:order][:address].to_i
        @address = ShippingAddress.find(@sta)
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
      when 3
        @order.post_code = params[:order][:new_add][:postal_code]
        @order.address = params[:order][:new_add][:address]
        @order.name = params[:order][new_add][:name]
    end
  end


  def create #注文確定
    if current_customer.cart_items.exists?
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      
      @add = params[:order][:add].to_i
      case @add
        when 1
          @order.postal_code = @customer.post_code
          @order.address = @customer.address
          @order.name = @customer.first_name + @customer.last_name
        when 2
          @order.post_code = params[:order][:postal_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
        when 3
          @order.post_code = params[:order][:post_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
      end
      @order.save
      # addressで住所モデル検索、該当データなければ新規作成
      if Address.find_by(residence: @order.address).nil?
        @address = Address.new
        @address.postal_code = @order.postal_code
        @address.residence = @order.adress
        @address.name = @order.name
        @address.customer_id = current_customer.id
        @address.save
      end

      # cart_itemsの内容をorder_itemsに新規登録
      current_customer.cart_items.each do |cart_item|
        order_item = @order.order_items.build
        order_item.order_id = @order.id
        order_item.product_id = cart_item.product_id
        order_item.quantity = cart_item.quantity
        order_item.tax_included_price = cart_item.product.price_without_tax
        order_item.save
        cart_item.destroy #order_itemに情報を移したらcart_itemは消去
      end
      render :thanks
    else
      redirect_to customer_top_path
      flash[:danger] = 'カートが空です。'
    end
  end

  def thanks

  end

  def index

  end

  def show

  end

  private

  def set_customer
    @customer = current_customer
  end

  def order_params
    params.require(:order).permit()
  end

end
