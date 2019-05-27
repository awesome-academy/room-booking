require 'rails_helper'

RSpec.describe User, type: :model do
  describe "columns" do
    subject {create :user}
    it{is_expected.to have_db_column(:name).of_type(:string)}
    it{is_expected.to have_db_column(:email).of_type(:string)}
    it{is_expected.to have_db_column(:password_digest).of_type(:string)}
    it{is_expected.to have_db_column(:remember_digest).of_type(:string)}
    it{is_expected.to have_db_column(:admin).of_type(:boolean)}
    it{is_expected.to have_db_column(:activation_digest).of_type(:string)}
    it{is_expected.to have_db_column(:activated).of_type(:boolean)}
    it{is_expected.to have_db_column(:activated_at).of_type(:datetime)}
    it{is_expected.to have_db_column(:reset_digest).of_type(:string)}
    it{is_expected.to have_db_column(:reset_sent_at).of_type(:datetime)}
  end

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
      it {expect(subject.activation_digest).not_to eq(nil)}
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
    let(:token) {User.new_token}
    let(:digest) {User.digest token}
    it {expect(BCrypt::Password.new(digest).is_password? token).to eq(true)}
  end

  describe ".token" do
    let(:token) {User.new_token}
    it {expect(token.size).to eq(22)}
  end

  describe "#remember" do
    subject {create :user}
    before {subject.remember}
    it {expect(subject.remember_token).not_to eq(nil)}
  end

  describe "#authenticated?" do
    subject {create :user}
    context "remember" do
      before {subject.remember}
      it {expect(subject.authenticated? "remember", subject.remember_token).to eq(true)}
    end

    context "activation" do
      it {expect(subject.authenticated? "activation", subject.activation_token).to eq(true)}
    end

    context "reset" do
      before {subject.create_reset_digest}
      it {expect(subject.authenticated? "reset", subject.reset_token).to eq(true)}
    end
  end

  describe "#forget" do
    subject {create :user}
    before do
      subject.remember
      subject.forget
    end
    it {expect(subject.remember_digest).to eq(nil)}
  end

  describe "#activate" do
    subject {create :user, :not_activated}
    before {subject.activate}
    it {expect(subject.activated).to eq(true)}
  end

  describe "#send_activation_email" do
    subject {create :user, :not_activated}
    before {subject.send_activation_email}
    it {expect(UserMailer.deliveries.count).to eq(1)}
  end

  describe "#create_reset_digest" do
    subject {create :user}
    before {subject.create_reset_digest}
    it {expect(subject.authenticated? "reset", subject.reset_token).to eq(true)}
  end

  describe "#send_password_reset_email" do
    subject {create :user}
    before do
      subject.create_reset_digest
      subject.send_password_reset_email
    end
    it {expect(UserMailer.deliveries.count).to eq(2)}
  end

  describe "#password_reset_expired?" do
    subject {create :user}
    before {subject.reset_sent_at = 4.hours.ago}
    it {expect(subject.password_reset_expired?).to eq(true)}
  end
end
