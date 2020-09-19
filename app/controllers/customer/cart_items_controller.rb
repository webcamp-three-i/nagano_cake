class Customer::CartItemsController < ApplicationController

  before_action :authenticate_customer!
  before_action :set_cart_item, only: [:index, :update, :create, :destroy, :destroy_all]
  before_action :set_customer

  def create
    @cart_item = current_customer.cart_items.build(cart_item_params) #親モデルの属する子モデルのインスタンス作成(newインスタンスと一緒)
    @current_item =  CartItem.find_by(product_it: @cart_item, customer_id: @cart_item.customer_id)
    if @current_item.nil? #カートに同じ商品がなかったら(同じ商品をデータベースに重複して保存させないif文)
      if @cart_item.save
        flash[:success] = "商品が追加されました"
        redirect_to customer_cart_items_path
      else 
        @cart_items = @customer.cart_items.all
        render :index
        flash[:danger] = "商品を追加できませんでした"
      end
    else #同じ商品があれば、paramsで数量だけ受け取り、customerのカート商品の既存数量に合算していく
      @current_item.quantity += params[:quantity].to_i
      @current_item.update(cart_item_params)
      redirect_to customer_cart_items_path
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to customer_cart_items_path
    flash[:info] = "商品を取り消しました。"
  end

  def index
    @cart_items = @customer.cart_items.all
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to customer_cart_items_path
      flash[:success] = "商品を更新しました！"
    end
  end

  def destroy_all #カート内アイテム全部消去
    @customer.cart_items.destroy_all
    redirect_to customer_cart_items_path
    flash[:info] = "カートを空にしました。"
  end


  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def set_customer
    @customer = current_customer #ログインしている会員を定義
  end

  def cart_item_params #カートに入れるボタンを実行でStrong Parametersを定義して受け取る
    prams.require(:cart_item).permit(:customer_id, :product_id, :quantity)
  end

end
