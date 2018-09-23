class User < ApplicationRecord
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # 参考
  # https://qiita.com/cigalecigales/items/f4274088f20832252374#2-devise%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E6%A6%82%E8%A6%81
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :timeoutable

  enumerize :role, in: %i[general management], default: :general
end
