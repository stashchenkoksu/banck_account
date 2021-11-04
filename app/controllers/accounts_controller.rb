# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :find_account, only: %i[show update destroy edit]
  before_action :find_user, only: %i[index new destroy create]

  def index
    @accounts = @user.accounts
  end

  def create
    @account = @user.accounts.new(account_params)

    if @account.save
      TransactionLog.new(account: @account, sum: @account.amount) if params[:account][:amount].to_i.positive?
      redirect_to user_accounts_path(@user)
    else
      render :new
    end
  end

  def update
    if @account.update(account_params)
      redirect_to user_accounts_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @account.destroy

    redirect_to user_accounts_path(@user)
  end

  def new
    @account = @user.accounts.new
  end

  private

  def find_account
    @account = Account.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def account_params
    permit = %i[amount currency]
    params.require(:account).permit(permit)
  end
end
