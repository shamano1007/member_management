FactoryBot.define do
  factory :user do
    sequence(:login_id) { |n| "loginid#{n}" }
    sequence(:password) { |n| "password#{n}" }
    password_confirmation { password }
    sequence(:name) { |n| "ユーザー名#{n}" }
    role { :general }
  end
end
