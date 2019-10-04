class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
# leader_userモデルがないため、自分でUserモデルであることを指定
  belongs_to :leader_user, class_name:'User'
  has_many :relationships, dependent: :destroy
  has_many :users ,through: :relationships ,source: :user
  has_many :tasks, dependent: :destroy, foreign_key: :post_group
  has_many :post_users ,through: :tasks ,source: :user 
  
  def invite_user(user)
    unless self.relationships.find_by(user_id: user.id)
      self.relationships.create(user_id: user.id, status: 'invite')
    end
  end
  
  def invite?(user)
    self.users.include?(user)
  end
  
  def confirm_status(user)
    self.relationships.find_by(user_id: user.id)
  end
  
end
