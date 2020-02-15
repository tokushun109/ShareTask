# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token, :reset_token
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_many :leader_groups, class_name: 'Group', foreign_key: :leader_user_id
  has_many :relationships, dependent: :destroy
  has_many :groups, through: :relationships, source: :group
  has_many :tasks, dependent: :destroy, foreign_key: :post_user_id
  has_many :post_groups, through: :tasks, source: :group

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def send_invitation_email(group)
    UserMailer.invitation(self, group).deliver_now
  end

  def send_acception_email(accept_user, group)
    UserMailer.acception(self, accept_user, group).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end
