class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :locations, dependent: :destroy

  def admin?
    admin ? true : false
  end
end
