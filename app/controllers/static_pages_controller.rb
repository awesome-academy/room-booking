class StaticPagesController < ApplicationController
  def home
    index
    @locations = Location.limit(Settings.controllers.static_pages.limit_location)
  end

  def index
    @search = Location.ransack params[:q]
    @locations = @search.result.page params[:page]
  end

  private

  def location_params
    params.require(:location).permit Location::LOCATION_PARAMS
  end

  def search_params
    params.slice :content, :start_date, :end_date, :field
  end
end
