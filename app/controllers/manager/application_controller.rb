module Manager
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    before_action :logged_in_user

    private
    def logged_in_user
      return if logged_in?
      store_location
      flash[:danger] = t "controllers.users.login_check"
      redirect_to login_url
    end
  end
end
