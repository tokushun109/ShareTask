# frozen_string_literal: true

class Record < ApplicationRecord
  validates :supplement, length: { maximum: 255 }
  validates :progress, presence: true,
            numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  belongs_to :task
  has_many_attached :images
end
