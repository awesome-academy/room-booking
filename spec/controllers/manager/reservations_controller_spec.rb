require 'rails_helper'

RSpec.describe Manager::ReservationsController, type: :controller do
  before do
    allow(subject).to receive(:current_user).and_return(create :user)
  end
  let(:user) {create :user}
  let(:reservation) {create :reservation}
  let(:location) {create :location}

  describe "before action" do
    it {is_expected.to use_before_action(:load_location)}
  end

  describe "GET #index" do
    before {get :index, params: {location_id: location.id, user_id: user.id}}
    it "responds successfully" do
      expect(response).to be_success
    end
    it "return a 200 response" do
      expect(response).to have_http_status :ok
    end
    it "return view index" do
      expect(response).to render_template :index
    end
  end

  describe "GET #search" do
    before do
      reservation
      get :index, params: {content: reservation.id, field: "all",
        user_id: user.id, location_id: location.id}
    end
    it "responds successfully" do
      expect(response).to be_success
    end
    it "return a 200 response" do
      expect(response).to have_http_status :ok
    end
    it "return view index" do
      expect(response).to render_template :index
    end
  end

  describe "PUT #update" do
    context "update success" do
      it "update with status" do
        put :update, params: {id: reservation.id, reservation:{status: "1"}, user_id: reservation.user.id}
        expect(response).to redirect_to(manager_location_reservations_path(@location))
      end
    end

    context "update reservation" do
      it "update fail" do
        put :update, params: {id: reservation.id, reservation:{status: "3"}, user_id: reservation.user.id}
        expect(response).to render_template(:edit)
      end
    end
  end
end
