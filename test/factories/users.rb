FactoryBot.define do
  factory :user, class: 'User' do
    username { Faker::Internet.username(specifier: 6..10) }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
