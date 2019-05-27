FactoryBot.define do
  factory :reservation do
    total_bill {rand(0..1000.0)}

    trait :pending do
      status {0}
    end

    trait :cancel do
      status {1}
    end

    user
  end
end
