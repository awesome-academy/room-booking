FactoryBot.define do
 factory :user do
    name {FFaker::Name.name}
    sequence(:email) {FFaker::Internet.email}
    password {"123456"}
    password_confirmation {"123456"}

    trait :admin do
      admin {true}
    end

    trait :user do
      admin {false}
    end

    trait :not_activated do
      activated {false}
    end

    trait :activated do
      activated {true}
    end
  end
end
