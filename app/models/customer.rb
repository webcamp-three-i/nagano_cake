class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :kana_first_name, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :kana_last_name, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :postal_code, presence: true, format: /\A[0-9]+\z/
  validates :residence, presence: true
  validates :phone_number, presence: true,format:/\A[0-9]+\z/

  #退会機能（有効会員はtrue、退会済み会員はfalse、有効会員はログイン可能)
  enum is_valid: {Available: true, Invalid: false}
    def active_for_authentication?
      super && (self.is_valid === "Available")
    end

end
