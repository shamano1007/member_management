class User < ApplicationRecord
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # 参考
  # https://qiita.com/cigalecigales/items/f4274088f20832252374#2-deviseモジュール概要
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :timeoutable

  enumerize :role, in: %i[general management], default: :general

  validates :login_id, presence: true, uniqueness: true, alphanumeric: true
  validates :name, presence: true
  validates :role, presence: true
  validates :password, presence: true, alphanumeric: true, confirmation: true
end
