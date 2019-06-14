class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :locations, dependent: :destroy

  def admin?
    admin ? true : false
  end

  def self.get_user_data
    data = []
    7.times do |time|
      count = User.where("created_at >= ? AND created_at < ?", time.days.ago.to_date, (time-1).days.ago.to_date).size
      data << {y: "#{time.days.ago.to_date}", a: count}
    end
    return data
  end

end
