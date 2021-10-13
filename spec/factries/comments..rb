FactoryBot.define do
  factory :comment do
    content { "test" }
    association :article
    association :user, factory: :comment_user
  end
end