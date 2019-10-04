class Task < ApplicationRecord
  validates :in_charge, presence: true, length: {maximum: 50 }
  validates :name, presence: true, length: {maximum: 50 }
  
  belongs_to :post_user, class_name:'User'
  belongs_to :post_group, class_name:'Group'
  has_many :records, dependent: :destroy
end
