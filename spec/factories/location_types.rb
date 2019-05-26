FactoryBot.define do
  factory :location_type do
    name{FFaker::Name.name}
    after(:create) do |location_type|
        create :location, location_type: location_type
    end
  end
end
