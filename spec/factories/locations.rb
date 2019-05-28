FactoryBot.define do
  factory :location do
    name{FFaker::Name.name}
    location{"Ha Noi"}
    national{"Viet Nam"}
    zip_code{"#100000"}
    description{"This is a description"}
    status{"0"}
    location_type
    user

    after(:create) do |location|
        create :room, location: location
    end
  end
end
