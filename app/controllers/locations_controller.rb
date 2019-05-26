class LocationsController < ApplicationController
  before_action :set_location, only: :show

  def index
    @search = Location.ransack params[:q]
    @locations = @search.result.page params[:page]
  end

  def show; end

  private
  def set_location
    @location = Location.find_by id: params[:id]
    return if @location
    flash[:error] = t(".location_not_found")
    redirect_to locations_path
  end
end
