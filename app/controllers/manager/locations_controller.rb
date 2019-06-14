class Manager::LocationsController < Manager::ApplicationController
  before_action :load_location, except: %i(get_data get_data1 new create)
  before_action :load_location_json, only: %i(get_data get_data1)

  def get_data
    @data = @location.get_reservation_data
    respond_to do |format|
      format.json {render json: @data}
    end
  end

  def get_data1
    @data1 = @location.get_reservation_data_1
    respond_to do |format|
      format.json {render json: @data1}
    end
  end

  def show
    @reservations = @location.reservations
    @reviews = @location.reviews
  end

  def new
    @location = Location.new.decorate
  end

  def create
    @location = Location.new location_params.merge user_id: current_user.id
    if @location.save
      flash[:success] = t(".created")
      redirect_to manager_root_path
    else
      flash[:error] = t(".create_unsuccess")
      render :new
    end
  end

  def edit; end

  def update
    if @location.update location_params
      flash[:success] = t(".location_updated")
      redirect_to manager_location_path
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
    @location = current_user.locations.find_by(id: params[:id])
    return @location.decorate if @location
    flash[:error] = "You not permited"
    redirect_to manager_root_path
  end

  def load_location_json
    @location = current_user.locations.find_by id: params[:id]
    return if @location
    flash[:error] = "You not permited"
    redirect_to manager_locations_path
  end
end
