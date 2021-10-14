FactoryBot.define do

  factory :tag, class: Tag do
    name { "tag1" }
  end

  factory :second_tag, class: Tag do
    name { "tag2" }
  end
end