FactoryBot.define do
  factory :business_career do
    user_id { 1 }
    start_date { "2018/#{(1..6).map { |i| format('%02d', i) }.sample}" }
    end_date { "2018/#{(7..12).map { |i| format('%02d', i) }.sample}" }
    sequence(:industries) { |n| "サービス#{n}" }
    overview { '概要' }
    role { 'PG' }
    memo { 'メモ' }
  end
end
