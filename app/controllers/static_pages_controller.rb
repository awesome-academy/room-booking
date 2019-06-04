class StaticPagesController < ApplicationController
  def home
    index
    @locations = Location.limit(Settings.controllers.static_pages.limit_location)
    @location_types = LocationType.order(:name)
      .page(params[:page]).per Settings.controllers.admin.location_types.pag
  end

  def index
    @search = Location.ransack params[:q]
    @locations = @search.result.includes(:location_type, :rooms).page params[:page]
  end

  private

  def location_params
    params.require(:location).permit Location::LOCATION_PARAMS
  end

  def location_type_params
    params.require(:location_type).permit LocationType::LOCATION_TYPE_PARAMS
  end

  def search_params
    params.slice :content, :start_date, :end_date, :field
  end
end
