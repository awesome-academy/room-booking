require 'rails_helper'

RSpec.describe Location, type: :model do
  context "Factory" do
    it{is_expected.to have_db_column(:name).of_type(:string)}
    it{is_expected.to have_db_column(:location).of_type(:string)}
    it{is_expected.to have_db_column(:national).of_type(:string)}
    it{is_expected.to have_db_column(:zip_code).of_type(:string)}
    it{is_expected.to have_db_column(:description).of_type(:text)}
    it{is_expected.to have_db_column(:status).of_type(:boolean)}
  end

  context "Validations" do
    before do
      subject{build(:location)}
    end

    context "name" do
      it{is_expected.to validate_presence_of(:name)}
    end

    context "location" do
      it{is_expected.to validate_presence_of(:location)}
    end

    context "national" do
      it{is_expected.to validate_presence_of(:national)}
    end

    context "zip_code" do
      it{is_expected.to validate_presence_of(:zip_code)}
    end

    context "description" do
      it{is_expected.to validate_presence_of(:description)}
    end
  end

  context "Associations" do
    it{is_expected.to belong_to(:user)}
    it{is_expected.to belong_to(:location_type)}
    it{is_expected.to have_many(:reviews)}
    it{is_expected.to have_many(:rooms)}
  end

  describe "scopes" do
    describe "list" do
      subject {Location.list}
      context "should return list locations not have" do
        it "pictures" do
          subject.each do |location|
            expect(location).not_to have_db_column(:pictures)
          end
        end
      end
    end

    describe "have_rooms_fit_with" do
      subject {Location.have_rooms_fit_with({range: "03/06/2019 - 06/06/2019", peoples: 30, rooms: 27})}
      context "should return true location" do
        it "enought rooms" do
          subject.each do |location|
            expect(location.total_rooms).to be >= 27
          end
        end

        it "enought capacity" do
          subject.each do |location|
            expect(location.total_capacity).to be >= 30
          end
        end
      end
    end
  end
end
