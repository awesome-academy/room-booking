class Admin::UsersController < Admin::ApplicationController
  before_action :load_user, except: %i(new index create search)

  def index
    @users = User.order(:name).page(params[:page])
      .per Settings.controllers.admin.users.pag
  end

  def search
    @users = SearchService.new(User, search_params, Settings.search_fields.user)
      .all_records
      .page(params[:page]).per Settings.controllers.admin.users.pag
    render :index
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params.merge confirmed_at: Time.now
    if @user.save
      flash[:success] = t ".create_success"
      redirect_to admin_users_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".update_success"
      redirect_to admin_users_url
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_fail"
    end
    redirect_to admin_users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def search_params
    params.slice :content, :field
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to admin_users_url
  end
end
