FactoryBot.define do
  factory :reservation_detail do
    description {FFaker::Lorem.characters 100}

    start_date {2.days.from_now}

    end_date {4.days.from_now}

    reservation
    room
  end
end
