require 'rails_helper'

RSpec.describe RoomsService, type: :model do
  context "Associations" do
    it{is_expected.to belong_to(:room)}
    it{is_expected.to belong_to(:service)}
  end
end
