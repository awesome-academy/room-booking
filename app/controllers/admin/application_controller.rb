class Admin::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  authorize_resource except: %i(home get_data)
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
end
