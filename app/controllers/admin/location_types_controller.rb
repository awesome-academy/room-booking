class Admin::LocationTypesController < Admin::ApplicationController
  before_action :load_location_type, except: %i(new index create search)

  def index
    @location_types = LocationType.order(:name)
      .page(params[:page]).per Settings.controllers.admin.location_types.pag
  end

  def search
    @location_types = SearchService.new(LocationType,
      search_params, Settings.search_fields.location_type).all_records
      .page(params[:page]).per Settings.controllers.admin.location_types.pag
    render :index
  end

  def show; end

  def new
    @location_type = LocationType.new
  end

  def create
    @location_type = LocationType.new location_type_params
    if @location_type.save
      flash[:success] = t ".create_success"
      redirect_to request.referer
    else
      render :new
    end
  end

  def edit; end

  def update
    if @location_type.update location_type_params
      flash[:success] = t ".update_success"
      redirect_to request.referer
    else
      render :edit
    end
  end

  private
  def location_type_params
    params.require(:location_type).permit :name
  end

  def search_params
    params.slice :content, :field
  end

  def load_location_type
    @location_type = LocationType.find_by id: params[:id]
    return if @location_type
    redirect_to admin_location_types_url
  end
end
