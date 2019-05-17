module Manager
  class StaticPagesController < Manager::ApplicationController
    def home
      @locations= Location.includes(:location_type).page(params[:page]).per Settings.page
    end
  end
end
