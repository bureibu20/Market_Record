FactoryBot.define do
  factory :user, class: User do
    name { 'user1' }
    email { 'user1@gmail.com' }
    password { '111111' }
    password_confirmation { '111111' }
    admin { false }
  end

  factory :second_user, class: User do
    name { 'user2' }
    email { 'user2@gmail.com' }
    password { '111111' }
    password_confirmation { '111111' }
    admin { false }
  end

  factory :admin_user, class: User do
    name { 'admin' }
    email { 'admin@gmail.com' }
    password { '111111' }
    password_confirmation { '111111' }
    admin { true }
  end
end