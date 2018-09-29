FactoryBot.define do
  factory :user do
    login_id { 'login_id' }
    password { 'password' }
    name { 'ユーザー名' }
    role { :general }
  end
end
