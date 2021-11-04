# frozen_string_literal: true

class UsersFilter < ApplicationService
  attr_accessor :params

  def initialize(params:, users:)
    @users = users
    @params = params
  end

  def call
    @params[:tag] ? @users.joins(:tags).where(tags: { title: params[:tag] }) : @users
  end
end
