require 'rails_helper'

RSpec.describe Manager::ReviewsController, type: :controller do
  before do
    allow(subject).to receive(:current_user).and_return(create :user)
  end
  let(:user) {create :user}
  let(:location) {create :location}

  describe "before action" do
    it {is_expected.to use_before_action(:load_location)}
  end

  describe "GET #index" do
    before {get :index, params: {user_id: user.id,location_id: location.id}}
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
end
