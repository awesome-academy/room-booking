class User < ApplicationRecord
  include UserDecorator

  USER_PARAMS = %i(name email password password_confirmation).freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :remember_token, :activation_token, :reset_token

  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :locations, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.validates.user.maximum_name}
  validates :email, presence: true, length: {maximum: Settings.validates.user.maximum_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.validates.user.minimum_pass}

  has_secure_password

  before_save :downcase_email
  before_create :create_activation_digest

  scope :activated, ->{where activated: true}

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_columns remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false unless digest
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update remember_digest: nil
  end

  def activate
    update activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.models.user.waiting_time.hours.ago
  end

  private
  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
