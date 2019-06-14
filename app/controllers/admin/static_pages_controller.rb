class Admin::StaticPagesController < Admin::ApplicationController
  before_action :check_admin
  def get_data
    @data = User.get_user_data
    respond_to do |format|
      format.json {render json: @data}
    end
  end

  def home
    @users = User.all
    @reviews = Review.count
    @locations = Location.count
  end

  private

  def user_params
    params.require(:user).permit :name
  end

  def check_admin
    return if current_user.admin?
    flash[:error] = "You not admin"
    redirect_to root_path
  end
end
