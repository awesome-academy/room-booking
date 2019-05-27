require 'rails_helper'

RSpec.describe ReservationDetail, type: :model do
  describe "columns" do
    subject {create :reservation_detail}
    it{is_expected.to have_db_column(:description).of_type(:string)}
    it{is_expected.to have_db_column(:start_date).of_type(:datetime)}
    it{is_expected.to have_db_column(:end_date).of_type(:datetime)}
  end

  describe "validations" do
    subject {create :reservation_detail}
    it {is_expected.to be_valid}

    before do
      allow(subject).to receive(:valid_start_date).and_return(true)
      allow(subject).to receive(:valid_end_date).and_return(true)
      allow(subject).to receive(:valid_days).and_return(true)
      allow(subject).to receive(:valid_room_ready).and_return(true)
    end

    describe "#start_date" do
      context "when blank" do
        it {is_expected.not_to allow_value("", nil).for(:start_date) }
      end

      context "when wrong format" do
        it {is_expected.not_to allow_value(FFaker::Lorem.name).for(:start_date)}
        it {is_expected.not_to allow_value("234/32/2019").for(:start_date)}
        it {is_expected.not_to allow_value("23/324/2019").for(:start_date)}
      end
    end

    describe "#end_date" do
      context "when blank" do
        it {is_expected.not_to allow_value("", nil).for(:end_date) }
      end

      context "when wrong format" do
        it {is_expected.not_to allow_value(FFaker::Lorem.name).for(:end_date)}
        it {is_expected.not_to allow_value("234/32/2019").for(:end_date)}
        it {is_expected.not_to allow_value("23/324/2019").for(:end_date)}
      end

    end
  end

  describe "associations" do
    subject {create :reservation_detail}
    before {allow(subject).to receive(:valid_room_ready).and_return(true)}
    it {is_expected.to belong_to(:reservation)}
    it {is_expected.to belong_to(:room)}
  end

  describe "#valid_start_date" do
    subject {build :reservation_detail}
    before do
      allow(subject).to receive(:valid_end_date).and_return(true)
      allow(subject).to receive(:valid_days).and_return(true)
      allow(subject).to receive(:valid_room_ready).and_return(true)
    end

    context "when wrong" do
      it {is_expected.not_to allow_value(2.days.ago).for(:start_date)}
    end

    context "when right" do
      it {is_expected.to allow_value(2.days.from_now).for(:start_date)}
    end
  end

  describe "#valid_end_date" do
    subject {build :reservation_detail}
    before do
      allow(subject).to receive(:valid_start_date).and_return(true)
      allow(subject).to receive(:valid_days).and_return(true)
      allow(subject).to receive(:valid_room_ready).and_return(true)
    end

    context "when wrong" do
      it {is_expected.not_to allow_value(2.days.ago).for(:end_date)}
    end

    context "when right" do
      it {is_expected.to allow_value(2.days.from_now).for(:end_date)}
    end
  end

  describe "#valid_days" do
    subject {build :reservation_detail}
    before do
      allow(subject).to receive(:valid_end_date).and_return(true)
      allow(subject).to receive(:valid_start_date).and_return(true)
      allow(subject).to receive(:valid_room_ready).and_return(true)
    end

    context "when wrong" do
      it {is_expected.not_to allow_value(subject.start_date).for(:end_date)}
    end

    context "when right" do
      it {is_expected.to allow_value(4.days.from_now).for(:end_date)}
    end
  end

  describe "#valid_room_ready" do
    subject {create :room, quantity: 1}
    let(:another_reservation_detail) {build :reservation_detail, room_id: subject.id}
    context "when full" do
      before do
        create :reservation_detail, room_id: subject.id
        another_reservation_detail.valid?
      end
      it {expect(another_reservation_detail.errors.full_messages).to eq(["Start date room is full"])}
    end
  end
end
