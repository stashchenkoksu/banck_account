# frozen_string_literal: true

class User < ApplicationRecord
  has_and_belongs_to_many :tags
  has_many :accounts

  validates :first_name, :last_name, :identify_number, presence: true

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end
end
