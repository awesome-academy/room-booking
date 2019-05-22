class Service < ApplicationRecord
  has_many :rooms_services, dependent: :destroy
  has_many :rooms, through: :rooms_services

  validates :name, presence: true, uniqueness: true, length: {maximum: Settings.validates.service.maximum_name}

  scope :option_list, ->{select :id, :name}
end
