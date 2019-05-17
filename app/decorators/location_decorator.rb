module LocationDecorator
  include ActionView::Helpers

  def select_option
    Location.pluck :name
  end

  def status_tag
    return {name: t("decorators.location.activated"),class: "badge badge-success"} if status
    {name: t("decorators.location.non_activated"),class: "badge badge-dark"}
  end

  def location_type_option
    LocationType.option_list.collect {|p| [ p.name, p.id ] }
  end
end
