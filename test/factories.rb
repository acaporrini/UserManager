FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User Name #{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    phone_number "000-1111"
  end

  factory :user_property do
    sequence(:name) { |n| "NAME" }
    sequence(:value) { |n| "VALUE " }
    user
  end
end
