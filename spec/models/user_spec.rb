require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    subject {create :user}
    it {is_expected.to be_valid}

    describe "#name" do
      context "when blank" do
        it {is_expected.not_to allow_value("", nil).for(:name) }
      end

      context "when too long" do
        before {allow(subject).to receive(:name).and_return(FFaker::Lorem.characters 100)}
        it {is_expected.not_to validate_length_of(:name).is_at_most(50)}
      end
    end

    describe "#email" do
      context "when blank" do
        it {is_expected.not_to allow_value("", nil).for(:email) }
      end

      context "when too long" do
        before do
          allow(subject).to receive(:email)
            .and_return(FFaker::Lorem.characters(255) << "@test.com")
        end
        it {is_expected.not_to validate_length_of(:email).is_at_most(255)}
      end

      context "when wrong format" do
        it {is_expected.not_to allow_value(FFaker::Lorem.name).for(:email) }
      end

      context "when conflict" do
        let(:another_user) {build :user, email: subject.email}
        it {expect(another_user).not_to validate_uniqueness_of(:email)}
      end
    end

    describe "#password" do
      it {is_expected.to have_secure_password}

      context "when blank" do
        before {allow(subject).to receive(:password)}
        it {is_expected.not_to allow_value("", nil).for(:password) }
      end

      context "when too long" do
        before do
          allow(subject).to receive(:password)
            .and_return(FFaker::Lorem.characters 3)
        end
        it {is_expected.not_to validate_length_of(:password).is_at_least(6)}
      end

      context "when wrong confirm" do
        before do
          allow(subject).to receive(:password_confirmation)
            .and_return(subject.password << "123")
        end
        it {is_expected.not_to validate_confirmation_of(:password)}
      end
    end
  end

  describe "associations" do
    subject {create :user}
    it {is_expected.to have_many(:reservations)}
    it {is_expected.to have_many(:reviews)}
    it {is_expected.to have_many(:locations)}
  end

  describe "callback" do
    subject {create :user}
    describe "before_save :downcase_email" do
      let(:another_user) {create :user, email: "ANHTU@GMAIL.COM"}
      it {expect(another_user.email).to eq("anhtu@gmail.com")}
    end

    describe "before_create :create_activation_digest" do

    end
  end

  describe "#activated" do
    subject {create :user}
    context "includes users with admin flag" do
      let(:another_user) {create :user, :activated}
      it {expect(User.activated).to include(another_user)}
    end

    context "excludes users without admin flag" do
      let(:another_user) {create :user, :not_activated}
      it {expect(User.activated).not_to include(another_user)}
    end
  end

  describe ".digest" do

  end
end
