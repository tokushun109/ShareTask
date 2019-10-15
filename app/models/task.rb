class Task < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50 }
  validates :time_limit, presence: true
  validates :in_charge, length: {maximum: 50 }
  validates :name, presence: true, length: {maximum: 50 }
  validates :status, presence: true, length: {maximum: 10 }
  
  belongs_to :post_user, class_name:'User'
  belongs_to :post_group, class_name:'Group'
  has_many :records, dependent: :destroy
end
