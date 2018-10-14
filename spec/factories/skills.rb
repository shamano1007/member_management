FactoryBot.define do
  factory :skill do
    sequence(:name) { |n| "ruby_#{n}" }
    sequence(:remarks) { |n| "オブジェクト指向スクリプト言語\nオブジェクト指向プログラミング\n#{n}" }
  end
end
