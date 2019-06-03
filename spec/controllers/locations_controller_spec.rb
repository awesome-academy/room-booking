require "rails_helper"

RSpec.describe LocationsController, type: :controller do
  let(:location_type) {create :location_type}
  let(:location) {create :location}
  let(:room) {create :room, quantity: 2, occupancy_limit: 4}

  describe "before action" do
    it {is_expected.to use_before_action(:load_location)}
  end

  describe "GET #show" do
    before {get :show, params: {id: location_type.locations.first.id, location_type_id: location_type.id}}
    context "with valid show" do
      it "assigns the requested location to @location" do
        expect(response).to have_http_status :ok
      end
      it "renders to the #show view" do
        expect(response).to render_template :show
      end
    end
  end

  describe "GET #index" do
    context "with no search params" do
      before {get :index}
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

    context "with search params" do
      before do
        get :index, params: {q: {name: room.location.national, have_rooms_fit_with: {
          range: "06/06/2019 - 07/06/2019",
          peoples: 8,
          rooms: 2
          }}}
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
  end
end
