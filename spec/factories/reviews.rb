FactoryBot.define do
  factory :review do
    comment{"This is a comment"}
    rate{"4"}
    user
  end
end
