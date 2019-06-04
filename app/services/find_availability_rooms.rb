class FindAvailabilityRooms
  def initialize location, params
    @start_date = Time.parse(params[:q][:have_rooms_fit_with][:range].split(" - ")[0])
    @end_date = Time.parse(params[:q][:have_rooms_fit_with][:range].split(" - ")[1])
    @rooms = location.rooms
  end

  def all_records
    find_rooms_availability
  end

  private
  def find_rooms_availability
    @rooms.each do |room|
      room.availability_rooms = room.quantity - rooms_were_used(room)
    end
  end

  def rooms_were_used room
    room.reservation_details.joins(:reservation).where("reservations.status <= 1")
      .where("start_date <= ?", @end_date).where("end_date >= ?", @start_date).size
  end
end
