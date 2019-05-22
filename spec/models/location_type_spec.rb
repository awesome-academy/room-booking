require 'rails_helper'

RSpec.describe LocationType, type: :model do
  context "Factory" do
    it{is_expected.to have_db_column(:name).of_type(:string)}
  end

  context "Validations" do
    before do
      subject{build(:location_type)}
    end

    context "name" do
      it{is_expected.to validate_presence_of(:name)}
      it{is_expected.to validate_length_of(:name).is_at_most(Settings.validates.location_type.maximum_name)}
      it{is_expected.to validate_uniqueness_of(:name)}
    end
  end

  context "Associations" do
    it{is_expected.to have_many(:locations)}
  end
end
