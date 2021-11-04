# frozen_string_literal: true

class Account < ApplicationRecord
  enum currencyes: %i[USD EUR RUB BYR YEN UAN]

  belongs_to :user
  has_many :transaction_log

  validates :user, presence: true
  validates :currency, inclusion: { in: currencyes.keys }

  def deposit(sum)
    self.amount += sum
    save
  end

  def withdrawal(sum)
    raise ActiveRecord::Rollback, 'Insufficient funds' if self.amount < sum

    self.amount -= sum
    save
  end
end
