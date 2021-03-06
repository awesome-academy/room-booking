FactoryBot.define do
  factory :room do
    name{FFaker::Name.name}
    occupancy_limit{2}
    living_room{1}
    bed_room{1}
    bath_room{1}
    number_of_bed{1}
    quantity{5}
    price{100.0}
    status{true}
    location
    bed_detail
  end
end
