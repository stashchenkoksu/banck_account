# frozen_string_literal: true

class TransferMoney < ApplicationService
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def call
    send("validate_data_#{params[:action]}")
    send("make_transaction_#{params[:action]}")
  end

  private

  def find_users
    @users = User.all
  end

  def validate_data_deposit
    validate_user_id(params[:deposit][:identify_number])
    validate_amount(params[:deposit][:amount].to_i)
  end

  def validate_data_transfer
    validate_user_id(params[:transfer][:identify_number_sender])
    validate_user_id(params[:transfer][:identify_number_recipient])
    validate_amount(params[:transfer][:amount].to_i)
  end

  def validate_user_id(identify_number)
    raise ActiveRecord::RecordNotFound, 'Wrong id№' unless User.find_by_identify_number(identify_number)
  end

  def validate_amount(amount)
    raise  ActiveRecord::RecordNotFound, 'Money amount should be positive' unless amount.positive?
  end

  def make_transaction_deposit
    user = User.find_by(identify_number: params[:deposit][:identify_number])
    currency = params[:deposit][:currency]
    amount = params[:deposit][:amount].to_i
    user.accounts.new(currency: currency).save unless user.accounts.any? { |account| account.currency == currency }
    user.accounts.find_by(currency: currency).deposit(amount)
    TransactionLog.new(account: user.accounts.find_by(currency: currency), sum: amount).save
  end

  def make_transaction_transfer
    sender = User.find_by(identify_number: params[:transfer][:identify_number_sender])
    recipient = User.find_by(identify_number: params[:transfer][:identify_number_recipient])
    currency = params[:transfer][:currency]
    amount = params[:transfer][:amount].to_i
    check_sender_account(sender, currency)
    ActiveRecord::Base.transaction do
      recipient.accounts.new(currency: currency).save unless recipient.accounts.find_by(currency: currency)
      sender.accounts.find_by(currency: currency).withdrawal(amount)
      recipient.accounts.find_by(currency: currency).deposit(amount)
      TransactionLog.new(account: sender.accounts.find_by(currency: currency), sum: -amount).save
      TransactionLog.new(account: recipient.accounts.find_by(currency: currency), sum: amount).save
    end
  end

  def check_sender_account(user, currency)
    error_massage = 'Sender does not have account in this currency'
    raise ActiveRecord::RecordNotFound, error_massage unless user.accounts.find_by(currency: currency)
  end
end
