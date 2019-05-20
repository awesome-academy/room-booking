class Manager::LocationsController < Manager::ApplicationController
  before_action :load_location, except: %i(new index create search destroy)

  def index
    @locations= Location.list.page(params[:page]).per Settings.page
  end

  def show; end

  def search
    @locations = SearchService.new(Location,search_params,Settings.search_fields
      .location).all_records.page(params[:page]).per Settings.page
    render :index
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new location_params
    if @location.save
      flash[:success] = t(".created")
      redirect_to manager_locations_path
    else
      flash[:error] = t(".create_unsuccess")
      render :new
    end
  end

  def edit; end

  def update
    if @location.update location_params
      flash[:success] = t(".location_updated")
      redirect_to manager_locations_path
    else
      render :edit
    end
  end

  private

  def location_params
    params.require(:location).permit Location::LOCATION_PARAMS
  end

  def search_params
    params.slice :content, :field
  end

  def load_location
    @location = Location.find_by id: params[:id]
    return if @location
    flash[:error] = t(".location_not_found")
    redirect_to manager_locations_path
  end
end
