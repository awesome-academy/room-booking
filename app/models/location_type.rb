class LocationType < ApplicationRecord
  has_many :locations

  mount_uploaders :pictures, PictureUploader

  validates :name, presence: true, uniqueness: true, length: {maximum: Settings.validates.location_type.maximum_name}

  LOCATION_TYPE_PARAMS = [:name, pictures: []].freeze

  scope :option_list, ->{select :id, :name}
end
