FactoryBot.define do
  factory :profile do
    user_id 1
    sequence(:birthdate) { |n| (Date.new(2000, 1, 1) - n.day).to_s }
    sequence(:address) { |n| "xxx#{n}県" }
    sequence(:closest_line) { |n| "xxx#{n}線" }
    sequence(:closest_station) { |n| "xxx#{n}駅" }
  end
end
