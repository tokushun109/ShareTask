class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
# leader_userモデルがないため、自分でUserモデルであることを指定
  belongs_to :leader_user, class_name:'User'
end
