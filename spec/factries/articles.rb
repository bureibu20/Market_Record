
FactoryBot.define do

  factory :article do
    title { "test_title" }
    content { "test_content" }
    association :user
    after(:build) do |article|
      tag = create(:tag)
      article.taggings << build(:tagging, article: article, tag: tag)
    end
  end

  factory :article2, class: Article do
    title { "test_title2" }
    content { "test_content2" }
    association :user, factory: :user1
    after(:build) do |article|
      tag = create(:tag_foo)
      article.taggings << build(:tagging, article: article, tag: tag)
    end
  end

end