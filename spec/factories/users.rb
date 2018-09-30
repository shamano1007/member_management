FactoryBot.define do
  factory :user do
    sequence(:login_id) { |n| "loginid#{n}" }
    sequence(:password) { |n| "password#{n}" }
    password_confirmation { password }
    sequence(:name) { |n| "ユーザー名#{n}" }
    role { %i[general admin].sample }
  end

  factory :user_admin, class: User do
    sequence(:login_id) { |n| "admin#{n}" }
    sequence(:password) { |n| "password#{n}" }
    password_confirmation { password }
    sequence(:name) { |n| "管理ユーザー名#{n}" }
    role { :admin }
  end

  factory :user_general, class: User do
    sequence(:login_id) { |n| "loginid#{n}" }
    sequence(:password) { |n| "password#{n}" }
    password_confirmation { password }
    sequence(:name) { |n| "ユーザー名#{n}" }
    role { :general }
  end
end
