# frozen_string_literal: true

class Record < ApplicationRecord
  validates :supplement, length: { maximum: 255 }
  validates :progress, presence: true, length: { maximum: 50 }

  belongs_to :task
end
