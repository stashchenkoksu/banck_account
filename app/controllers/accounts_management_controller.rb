# frozen_string_literal: true

class AccountsManagementController < ApplicationController
  def index; end

  def deposit
    TransferMoney.call(params) if params[:deposit]
  end

  def transfer
    TransferMoney.call(params) if params[:transfer]
  end
end
