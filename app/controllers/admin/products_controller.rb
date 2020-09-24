class Admin::ProductsController < ApplicationController
  before_action :set_genres, only: [:new, :edit, :index, :create, :update] #productsコントローラで定義済みのアクションを実行前に作動
  before_action :authenticate_admin!

  def index
    @products = Product.all.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path(@product)
      flash[:notice] = "投稿に成功しました"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_path(@product)
      flash[:notice] = "変更を保存しました"
    else
      render :edit
    end
  end


  private

  def product_params
    params.require(:product).permit(:name, :image, :description, :genre_id, :price_without_tax, :sales_status)
  end

  def set_genres
    @genres = Genre.where(valid_flag: true) #new.htmlのform_forで使用するジャンルの定義。DBから有効フラグがtrueを取り出す。
  end
end
