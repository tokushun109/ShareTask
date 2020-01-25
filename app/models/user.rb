# frozen_string_literal: true

class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password,presence: true, length: {minimum: 6}, allow_nil: true

  has_many :leader_groups, class_name: 'Group', foreign_key: :leader_user
  has_many :relationships, dependent: :destroy
  has_many :groups, through: :relationships, source: :group
  has_many :tasks, dependent: :destroy, foreign_key: :post_user
  has_many :post_groups, through: :tasks, source: :group
end
