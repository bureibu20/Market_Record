FactoryBot.define do

  factory :tag1 do
    name { "tag1" }
  end

  factory :tag2, class: Tag do
    name { "tag2" }
  end

  factory :tag3, class: Tag do
    name { "tag3" }
  end
end