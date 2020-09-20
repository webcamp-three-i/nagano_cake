module ApplicationHelper
  #税込価格表示のヘルパー(税別価格に10%の消費税を加算。小数点以下はfloorで切り捨て。)
  def price_include_tax(price_without_tax) 
    (price_without_tax * 1.10).floor
  end
end
