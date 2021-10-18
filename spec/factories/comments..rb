FactoryBot.define do
  factory :comment do
    user { nil }
    article { nil }
    content { "test" }
  end
end