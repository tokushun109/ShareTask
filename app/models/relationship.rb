# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
