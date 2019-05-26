require "rails_helper"

RSpec.describe Manager::RoomsController, type: :controller do
  before do
    allow(subject).to receive(:current_user).and_return(create :user)
  end
  let(:location) {create :location, user_id: subject.current_user.id}
  let(:room) {create :room}
  let(:service) {create :service}

  describe "before action" do
    it {is_expected.to use_before_action(:load_location)}
    it {is_expected.to use_before_action(:load_room)}
  end

  describe "GET #index" do
    before {get :index, params: {location_id: location.id}}
    it "responds successfully" do
      expect(response).to be_success
    end
    it "returns a 200 response" do
      expect(response).to have_http_status :ok
    end
    it "returns view index" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before {get :show, params: {id: location.rooms.first.id, location_id: location.id}}
    context "with valid show" do
      it "assigns the requested room to @room" do
        expect(response).to have_http_status :ok
      end
      it "renders to the #show view" do
        expect(response).to render_template :show
      end
    end
  end

  describe "GET #search" do
    before do
      room
      get :index, params: {content: room.name, field: "all", location_id: location.id}
    end
    it "responds successfully" do
      expect(response).to be_success
    end
    it "returns a 200 response" do
      expect(response).to have_http_status :ok
    end
    it "returns view index" do
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    before do
      room
      get :new, params: {content: room.name, location_id: location.id}
    end
    it "assigns a blank room to the view" do
      expect(assigns(:room)).to be_a_new(Room)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before {
        post :create, params: {room: attributes_for(:room, bed_detail_id: 1,
          services: [service.id]), location_id: location.id}
      }
      it "creates a new room" do
        expect(assigns(:room)).to be_a Room
      end
    end

    context "invalid params" do
      before {
        post :create, params: {room: attributes_for(:room, services: [service.id]), location_id: location.id}
      }
      it "create fail" do
        expect(flash[:error]).to match(I18n.t("flash.create_unsuccess"))
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    before {get :edit, params: {id: room.id, location_id: room.location.id}}
    it {is_expected.to respond_with(:ok)}
    it {is_expected.to render_template(:edit)}
    it {expect(assigns(:room)).to eq(room)}
  end

  describe "PUT #update" do
    context "update success" do
      it "update with name " do
        put :update, params: {id: room.id, room:{name: "Vip1"}, location_id: room.location.id}
        expect(flash[:success]).to match(I18n.t("flash.room_updated"))
        expect(response).to redirect_to(manager_location_rooms_path)
      end
    end

    context "update room" do
      it "update fail " do
        put :update , params: {id: room.id, room:{name: ""}, location_id: room.location.id}
        expect(response).to render_template(:edit)
      end
    end
  end
end
