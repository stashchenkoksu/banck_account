# frozen_string_literal: true

class TransactionLog < ApplicationRecord
  belongs_to :account
end
