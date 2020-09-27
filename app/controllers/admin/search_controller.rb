class Admin::SearchController < ApplicationController
  before_action :authenticate_admin! #付けないとログイン前でも検索できてしまう。

  def search
    @content = params["search"]["content"]
    @model = params["search"]["model"]
    @method = params["search"]["method"]
    @records = search_for(@content, @model, @method) #検索するというメソッドの引数にして代入 
  end

  private

  def search_for(content, model, method) #上記のsearch_forメソッドを定義する。
    if model == 'product'
      if method == 'perfect'
        Product.where('name LIKE ?' ,content)
      elsif method == 'forward'
        Product.where('name LIKE ?' , content+'%' )
      elsif  method == 'backward'
        Product.where('name LIKE ?' , '%'+content )
      else
        Product.where('name LIKE ?' , '%'+content+'%' )
      end
    end
  end
end
