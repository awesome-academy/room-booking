class Room < ApplicationRecord
  include RoomDecorator

  has_many :rooms_services, dependent: :destroy
  has_many :services, through: :rooms_services
  has_many :images, as: :imageable, dependent: :destroy
  has_many :reservation_details
  has_many :reservations, through: :reservation_details
  belongs_to :location
  belongs_to :bed_detail
  accepts_nested_attributes_for :rooms_services

  mount_uploaders :pictures, PictureUploader

  validates_presence_of :name, :occupancy_limit, :living_room, :bed_room,
    :bath_room, :number_of_bed, :quantity


  ROOM_PARAMS = [:location, :name, :occupancy_limit, :living_room, :bed_room,
    :bath_room, :number_of_bed, :quantity, :price, :location_id, :bed_detail_id,
    :created_at, :updated_at, pictures: [], services: []].freeze

  scope :by_location_id, -> (location_id){ where("location_id = ?", location_id) }
  scope :list, lambda do
    select :id, :name, :occupancy_limit, :quantity, :price, :created_at,
      :updated_at, :status
  end
end
