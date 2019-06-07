class UserDecorator < ApplicationDecorator
  delegate_all

  def role_badge
    return h.label_tag nil, "Admin", class: "badge badge-warning" if admin?
    h.label_tag nil, "User", class: "badge badge-primary"
  end

  def status_badge
    return h.label_tag nil, "Activated", class: "badge badge-success" if active_for_authentication?
    h.label_tag nil, "Non Activated", class: "badge badge-dark"
  end
end
