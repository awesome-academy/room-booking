class LocationType < ApplicationRecord
  has_many :locations

  validates :name, presence: true, uniqueness: true, length: {maximum: Settings.validates.location_type.maximum_name}

  scope :option_list, ->{select :id, :name}
end
