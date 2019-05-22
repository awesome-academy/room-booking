require 'rails_helper'

RSpec.describe BedDetail, type: :model do
  context "Factory" do
    it{is_expected.to have_db_column(:name).of_type(:string)}
  end

  context "Associations" do
    it{is_expected.to have_many(:rooms)}
  end
end
