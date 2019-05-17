module RoomDecorator
  include ActionView::Helpers

  def select_option
    Location.pluck :name
  end

  def status_tag
    return {name: t("decorators.room.activated"),class: "badge badge-success"} if status
    {name: t("decorators.room.non_activated"),class: "badge badge-dark"}
  end

  def bed_detail_option
    BedDetail.option_list.collect {|p| [ p.name, p.id ] }
  end

  def service_option
    Service.option_list.collect {|p| [ p.name, p.id ] }
  end
end
