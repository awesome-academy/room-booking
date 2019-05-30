require "rails_helper"

RSpec.describe Manager::LocationsController, type: :controller do
  before do
    allow(subject).to receive(:current_user).and_return(create :user)
  end
  let(:location_type) {create :location_type}
  let(:location) {create :location}

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

  describe "GET #new" do
    before do
      location
      get :new, params: {content: location.name, location_type_id: location_type.id}
    end
    it "assigns a blank location to the view" do
      expect(assigns(:location)).to be_a_new(Location)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before {
        post :create, params: {location: attributes_for(:location), location_type_id: location_type.id}
      }
      it "creates a new location" do
        expect(assigns(:location)).to be_a Location
      end
    end

    context "invalid params" do
      before {
        post :create, params: {location: attributes_for(:location), location_type_id: location_type.id}
      }
      it "create fail" do
        expect(flash[:error]).to match(I18n.t("flash.create_unsuccess"))
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    before {get :edit, params: {id: location.id, location_type_id:
      location.location_type.id}}
    it {is_expected.to respond_with(:ok)}
    it {is_expected.to render_template(:edit)}
    it {expect(assigns(:location)).to eq(location)}
  end

  describe "PATCH #update" do
    context "update success" do
      it "update with name" do
        put :update, params: {id: location.id, location:{name: "Ha Noi"},
          location_type_id: location.location_type.id}
        expect(flash[:success]).to match(I18n.t("flash.location_updated"))
        expect(response).to redirect_to manager_location_path
      end
    end

    context "update location" do
      it "update fail" do
        put :update, params: {id: location.id, location:{name: ""}, location_type_id: location.location_type.id}
        expect(response).to render_template(:edit)
      end
    end
  end
end
