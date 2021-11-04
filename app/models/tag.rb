# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :users

  validates :title, presence: true
end
