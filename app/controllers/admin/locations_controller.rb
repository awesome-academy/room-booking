class Admin::LocationsController < Admin::ApplicationController
  before_action :load_location, only: %i(show update)

  def index
    @locations = Location.order(:name)
      .page(params[:page]).per Settings.controllers.admin.locations.pag
  end

  def search
    @locations = SearchService.new(Location,
      search_params, Settings.search_fields.location).all_records
      .page(params[:page]).per Settings.controllers.admin.locations.pag
    render :index
  end

  def show; end

  def update
    if @location.update location_params
      flash[:success] = t ".activate_success"
      redirect_to request.referer
    else
      render :show
    end
  end

  private
  def location_params
    params.require(:location).permit :status
  end

  def search_params
    params.slice :content, :field
  end

  def load_location
    @location = Location.find_by id: params[:id]
    return if @location
    redirect_to admin_locations_url
  end
end
