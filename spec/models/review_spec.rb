require 'rails_helper'

RSpec.describe Review, type: :model do
  context "Factory" do
    it{is_expected.to have_db_column(:comment).of_type(:string)}
    it{is_expected.to have_db_column(:rate).of_type(:integer)}
  end

  context "Associations" do
    it{is_expected.to belong_to(:user)}
    it{is_expected.to belong_to(:location)}
  end
end
