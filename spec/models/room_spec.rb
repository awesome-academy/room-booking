require 'rails_helper'

RSpec.describe Room, type: :model do
  context "Factory" do
    it{is_expected.to have_db_column(:name).of_type(:string)}
    it{is_expected.to have_db_column(:occupancy_limit).of_type(:integer)}
    it{is_expected.to have_db_column(:living_room).of_type(:integer)}
    it{is_expected.to have_db_column(:bed_room).of_type(:integer)}
    it{is_expected.to have_db_column(:bath_room).of_type(:integer)}
    it{is_expected.to have_db_column(:number_of_bed).of_type(:integer)}
    it{is_expected.to have_db_column(:quantity).of_type(:integer)}
    it{is_expected.to have_db_column(:price).of_type(:decimal)}
    it{is_expected.to have_db_column(:status).of_type(:boolean)}
  end

  context "Validations" do
    before do
      subject{build(:room)}
    end

    context "name" do
      it{is_expected.to validate_presence_of(:name)}
    end

    context "occupancy_limit" do
      it{is_expected.to validate_presence_of(:occupancy_limit)}
    end

    context "living_room" do
      it{is_expected.to validate_presence_of(:living_room)}
    end

    context "bed_room" do
      it{is_expected.to validate_presence_of(:bed_room)}
    end

    context "bath_room" do
      it{is_expected.to validate_presence_of(:bath_room)}
    end

    context "number_of_bed" do
      it{is_expected.to validate_presence_of(:number_of_bed)}
    end

    context "quantity" do
      it{is_expected.to validate_presence_of(:quantity)}
    end

    context "price" do
      it{is_expected.to validate_presence_of(:price)}
    end
  end

  context "Associations" do
    it{is_expected.to belong_to(:location)}
    it{is_expected.to belong_to(:bed_detail)}
    it{is_expected.to have_many(:rooms_services)}
    it{is_expected.to have_many(:reservation_details)}
    it{is_expected.to have_many(:services)}
    it{is_expected.to have_many(:reservations)}
  end
end
