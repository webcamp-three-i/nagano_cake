# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |n|
    Customer.create!(
      email: "test#{n + 1}@test.com",
      first_name: "名#{n + 1}",
      last_name: "姓#{n + 1}",
      kana_first_name: "セイ",
      kana_last_name: "メイ",
      password: "123456",
      postal_code: "1234567",
      residence: "xxxxxxxxxxxxxxxxxxxxxxxxxxxx#{n + 1}",
      phone_number: "09012345678"
    )
end

  Admin.create!(
    email: "admin@admin",
    password: 111111
  )

  Genre.create!(
    name: "ホールケーキ",
    valid_flag: true
  )
  Genre.create!(
    name: "パンダケーキ",
    valid_flag: true
  )
  Genre.create!(
    name: "チーズケーキ",
    valid_flag: true
  )
  Genre.create!(
    name: "モンブラン",
    valid_flag: true
  )
  Genre.create!(
    name: "ミルクレープ",
    valid_flag: true
  )
  Genre.create!(
    name: "ミルフィーユ",
    valid_flag: true
  )
  Genre.create!(
    name: "チョコレートケーキ",
    valid_flag: true
  )
  Genre.create!(
    name: "ロールケーキ",
    valid_flag: true
  )
  Genre.create!(
    name: "マカロン",
    valid_flag: true
  )
  Genre.create!(
    name: "ケーキ",
    valid_flag: true
  )
  Genre.create!(
    name: "シュークリーム",
    valid_flag: true
  )


   Product.create!(
    name: "ショートケーキ",
    description: "甘くて美味しい　イチゴのショートケーキ",
    price_without_tax: "400",
    genre_id: 10,
    sales_status: true,
    image: open("./app/assets/images/ケーキ3.jpg")
  )
  Product.create!(
    name: "チーズケーキ",
    description: "ほんのり甘酸っぱい　チーズケーキ",
    price_without_tax: "450",
    genre_id: 3,
    sales_status: true,
    image: open("./app/assets/images/20130625125049.jpg")
  )
  Product.create!(
    name: "マカロン",
    description: "高級感のあるマカロン",
    price_without_tax: "200",
    genre_id: 9,
    sales_status: true,
    image: open("./app/assets/images/59c9bb1e3c85e.jpg")
  )
  Product.create!(
    name: "ケーキ",
    description: "お洒落なケーキ",
    price_without_tax: "250",
    genre_id: 10,
    sales_status: true,
    image: open("./app/assets/images/5e2fc3aa682c1.jpeg")
  )
  Product.create!(
    name: "ロールケーキ",
    description: "定番のロールケーキ　クリームには蜂蜜の隠し味",
    price_without_tax: "700",
    genre_id: 8,
    sales_status: true,
    image: open("./app/assets/images/41maa3p3-fL.jpg")
  )
  Product.create!(
    name: "モンブラン",
    description: "みんな大好きモンブラン",
    price_without_tax: "500",
    genre_id: 4,
    sales_status: true,
    image: open("./app/assets/images/get.jpeg")
  )
  Product.create!(
    name: "チョコレートケーキ",
    description: "ヨーロッパ伝統の本格チョコケーキ",
    price_without_tax: "600",
    genre_id: 7,
    sales_status: true,
    image: open("./app/assets/images/get11.jpeg")
  )
  Product.create!(
    name: "ミルクレープ",
    description: "一枚一枚てやきしたクレープに濃厚な生クリームとカスタードを合わせて焼きました。",
    price_without_tax: "430",
    genre_id: 5,
    sales_status: true,
    image: open("./app/assets/images/img_sizzle_millecrepes.jpg")
  )
  Product.create!(
    name: "ミルフィーユケーキ",
    description: "しっとりしたクリームとサクサクのパイ生地が何層にも重なったミルフィーユ",
    price_without_tax: "390",
    genre_id: 6,
    sales_status: true,
    image: open("./app/assets/images/recipe-title-main-1394.jpg")
  )
  Product.create!(
    name: "チョコレートケーキ2",
    description: "ビターチョコを使って大人味にも変化するガトー・ショコラ",
    price_without_tax: "2600",
    genre_id: 7,
    sales_status: true,
    image: open("./app/assets/images/be2fc17b17fc961ab1a3006c45853728.jpeg")
  )
  Product.create!(
    name: "パンダケーキ",
    description: "チョコとミルクのホイップでできた可愛いパンダケーキ",
    price_without_tax: "1500",
    genre_id: 2,
    sales_status: true,
    image: open("./app/assets/images/518K-0NFZAL._AC_.jpg")
  )
  Product.create!(
    name: "パンダケーキ(フルーツ)",
    description: "周りはポッキー、上にはフルーツの盛り合わせにパンダをのせてみました",
    price_without_tax: "900",
    genre_id: 2,
    sales_status: true,
    image: open("./app/assets/images/images.jpeg")
  )
  Product.create!(
    name: "猫のシュークリーム２個",
    description: "大好きな猫をシュークリームにのせて作ってみました",
    price_without_tax: "600",
    genre_id: 11,
    sales_status: true,
    image: open("./app/assets/images/5ae123c3d894d.jpeg")
  )
  Product.create!(
    name: "パンダケーキ(ホール)",
    description: "ホールのケーキにたくさんの可愛いパンダをのせました",
    price_without_tax: "2200",
    genre_id: 2,
    sales_status: true,
    image: open("./app/assets/images/mig.jpeg")
  )
  Product.create!(
    name: "ホールケーキ",
    description: "たくさんのクリームと美味しいイチゴを６個　誕生日などにオススメ",
    price_without_tax: "3200",
    genre_id: 1,
    sales_status: true,
    image: open("./app/assets/images/ケーキ2.jpg")
  )
  Product.create!(
    name: "イチゴのホールケーキ",
    description: "たくさんイチゴをのせたハート型のイチゴケーキ",
    price_without_tax: "4000",
    genre_id: 1,
    sales_status: true,
    image: open("./app/assets/images/ケーキ4.jpeg")
  )
  Product.create!(
    name: "チーズケーキ(ホール)",
    description: "とろけてしまうほどの美味しさ",
    price_without_tax: "3800",
    genre_id: 3,
    sales_status: true,
    image: open("./app/assets/images/recipe_img_usual015_01.jpg")
  )
  Product.create!(
    name: "チーズケーキ",
    description: "とろけてしまうほどの美味しさ",
    price_without_tax: "3800",
    genre_id: 3,
    sales_status: true,
    image: open("./app/assets/images/carousel_0a5bb2e9bdbd091fc6cefe314c78b6b4.jpg")
  )
  Product.create!(
    name: "いちごのチョコレートケーキ",
    description: "たくさんのいちごととろけるチョコレートのケーキ",
    price_without_tax: "3100",
    genre_id: 7,
    sales_status: true,
    image: open("./app/assets/images/ケーキ1.jpg")
  )


  9.times do |n|
  ShippingAddress.create!(
    name: "test#{n + 1}",
    postal_code: "123456#{n + 1}",
    residence: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx#{n + 1}",
    customer_id: n + 1
  )
end

5.times do |n|
  Order.create!(
    customer_id: n +1,
    address: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx#{n + 1}",
    postal_code: "123456#{n + 1}",
    name: "test#{n + 1}",
    postage: "800",
    billing_amount: "#{1000 + (n * 1000) +800}",
    payment_method: "クレジットカード"
  )
end

5.times do |n|
  OrderProduct.create!(
    product_id: n + 1,
    order_id: n + 1,
    quantity: n + 3,
    tax_included_price: "#{1000 + (n * 1000)}",
    production_status: 0
  )
end

