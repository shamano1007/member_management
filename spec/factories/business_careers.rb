FactoryBot.define do
  factory :business_career do
    user_id { 1 }
    start_date { '2018/11' }
    end_date { '2018/11' }
    sequence(:industries) { |n| "サービス#{n}" }
    overview { '概要' }
    role { 'PG' }
    memo { 'メモ' }
  end
end
