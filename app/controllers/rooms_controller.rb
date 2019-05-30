class RoomsController < ApplicationController
  before_action :load_room, only: %i(show)

  def index
    @rooms= Room.list.page(params[:page]).per Settings.page
  end

  def show; end

  private

  def room_params
    params.require(:room).permit Room::ROOM_PARAMS
  end

  def load_location
    @location =Location.find_by id: params[:location_id]
    return if @location
    flash[:error] = t(".location_not_found")
    redirect_to locations_path
  end

  def load_room
    @room = Room.find_by id: params[:id]
    return if @room
    flash[:error] = t(".room_not_found")
    redirect_to rooms_path
  end
end
