module ApplicationHelper
  #税込価格表示のヘルパー
  def price_include_tax(price_without_tax) 
    (price_without_tax * 1.08).floor
  end
end
