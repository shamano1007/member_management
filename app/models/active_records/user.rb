class User < ApplicationRecord
  extend Enumerize
  has_one :profile, dependent: :destroy
  has_many :business_careers, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # 参考
  # https://qiita.com/cigalecigales/items/f4274088f20832252374#2-deviseモジュール概要
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :timeoutable

  enumerize :role, in: %i[general admin], default: :general

  validates :login_id, presence: true, uniqueness: true,
                       alphanumeric: true, length: { minimum: 6 }
  validates :name, presence: true
  validates :role, presence: true
  validates :password, presence: true, on: :update_password
  validates :password, presence: true, alphanumeric: true,
                       length: { minimum: 6 }, confirmation: true,
                       if: :password_validate?

  def update_without_current_password(params)
    assign_attributes(params)
    result = save(context: :update_password)
    clean_up_passwords
    result
  end

  private

  def password_validate?
    new_record? || password.present? || password_confirmation.present?
  end
end
