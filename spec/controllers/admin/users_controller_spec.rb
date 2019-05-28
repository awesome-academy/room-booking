require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:admin_user) {create :user, :admin, :activated}
  let(:user) {create :user}
  before do
    allow(subject).to receive(:current_user).and_return(admin_user)
  end

  describe "before action" do
    it {is_expected.to use_before_action(:logged_in_user)}
    it {is_expected.to use_before_action(:admin_user)}
    it {is_expected.to use_before_action(:load_user)}
  end

  describe "GET #index" do
    before {get :index}
    it {is_expected.to respond_with(:ok)}
    it {is_expected.to render_template(:index)}
    it {expect(assigns[:users]).to eq([subject.current_user])}
  end

  describe "GET #search" do
    before {get :index, params: {content: subject.current_user.name, field: "all"}}
    it {is_expected.to respond_with(:ok)}
    it {is_expected.to render_template(:index)}
    it {expect(assigns[:users]).to eq([subject.current_user])}
  end

  describe "GET #show" do
    before do
      user
      get :show, params: {id: user.id}
    end
    it {is_expected.to respond_with(:ok)}
    it {is_expected.to render_template(:show)}
    it {expect(assigns[:user]).to eq(user)}
  end

  describe "GET #new" do
    before {get :new}
    it {is_expected.to respond_with(:ok)}
    it {is_expected.to render_template(:new)}
    it {expect(assigns[:user]).to be_a_new(User)}
  end

  describe "POST #create" do
    let(:params) {attributes_for(:user)}
    let(:wrong_params ) {attributes_for(:user, email: "abc")}
    context "when success" do
      it {expect{post :create, params: {user: params}}.to change(User, :count).by(1)}
      it do
        post :create, params: {user: params}
        is_expected.to set_flash
      end
      it do
        post :create, params: {user: params}
        is_expected.to redirect_to(action: :index)
      end
    end

    context "when fail" do
      it {expect{post :create, params: {user: wrong_params}}.to change(User, :count).by(0)}
      it do
        post :create, params: {user: wrong_params}
        is_expected.not_to set_flash
      end
      it do
        post :create, params: {user: wrong_params}
        is_expected.to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    before {get :edit, params: {id: user.id}}
    it {is_expected.to respond_with(:ok)}
    it {is_expected.to render_template(:edit)}
    it {expect(assigns :user).to eq(user)}
  end

  describe "PUT #update" do
    let(:params) {attributes_for(:user, email: "abc@xyz.com")}
    let(:wrong_params ) {attributes_for(:user, email: "abc")}
    context "when success" do
      before {put :update, params: {user: params, id: user.id}}
      it {expect(assigns(:user).email).not_to eq(user.email)}
      it {is_expected.to set_flash}
      it {is_expected.to redirect_to(action: :index)}
    end

    context "when fail" do
      before {put :update, params: {user: wrong_params, id: user.id}}
      it {expect(assigns(:user).errors.messages).not_to eq({})}
      it {is_expected.not_to set_flash}
      it {is_expected.to render_template(:edit)}
    end
  end

  describe "DELETE #destroy" do
    context "when success" do
      before {delete :destroy, params: {id: user.id}}
      it {is_expected.to set_flash[:success]}
      it {is_expected.to redirect_to(action: :index)}
    end

    context "when fail" do
      before {delete :destroy, params: {id: -1}}
      it {is_expected.to set_flash[:danger]}
      it {is_expected.to redirect_to(action: :index)}
    end
  end
end
