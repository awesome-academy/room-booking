class BedDetail < ApplicationRecord
  has_many :rooms

  scope :option_list, ->{select :id, :name}
end
