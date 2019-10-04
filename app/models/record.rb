class Record < ApplicationRecord
  validates :supplement, presence: true, length: {maximum: 255 }
  validates :progress, presence: true, length: {maximum: 50 }
    
  belongs_to :task
end
