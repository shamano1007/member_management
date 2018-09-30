FactoryBot.define do
  factory :user do
    login_id { 'loginid01' }
    password { 'password' }
    password_confirmation { 'password' }
    name { 'ユーザー名' }
    role { :general }
  end
end
