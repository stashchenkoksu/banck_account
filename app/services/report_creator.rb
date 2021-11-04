# frozen_string_literal: true

class ReportCreator < ApplicationService
  def initialize(type, params = nil)
    @type = type
    @params = params
  end

  def call
    case @type
    when '1'
      unless @params.nil?
        user_ids = @params[:user_ids]
        time_period = @params[:time_period]
      end
      deposition_amount(user_ids, time_period)
    when '2'
      extremums
    when '3'
      all_accounts_sum
    end
  end

  private

  def deposition_amount(users_ids = %w[CROOK054130SZ8SK WALTE608284TU2XC], time_period = Time.now - 1.year..Time.now)
    Account.joins(:transaction_log, :user).where(user: { identify_number: users_ids }, transaction_log: { created_at: time_period }).where('transaction_log.sum > 0').group(
      :identify_number, :currency
    ).sum(:sum).to_a
  end

  def extremums(tag = %w[sangria_1 green_2], time_period = Time.now - 1.year..Time.now)
    Account.joins(:transaction_log, user: :tags).where(tags: { title: tag }, transaction_log: { created_at: time_period }).where('transaction_log.sum > 0').group(:title, :currency).select(
      'MAX(sum) AS max', 'MIN(sum) AS min', 'AVG(sum) AS avg', 'title', 'currency'
    )
  end

  def all_accounts_sum(tag = 'sangria_1')
    Account.joins(user: :tags).where(tags: { title: tag }).group(:title, :currency).sum(:amount)
  end
end
