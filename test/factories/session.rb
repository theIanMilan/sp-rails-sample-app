FactoryBot.define do
  factory :session, class: 'Session' do
    association :user
    last_used_at { Time.now }
    status { true }
  end
end
