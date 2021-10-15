
FactoryBot.define do

  factory :article do
    title { "test_title" }
    content { "test_content" }
  end

  factory :article2, class: Article do
    title { "test_title2" }
    content { "test_content2" }
  end
end