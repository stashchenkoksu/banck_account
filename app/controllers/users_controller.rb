# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, only: %i[show update destroy edit]
  before_action :find_tags, only: %i[edit create new]

  def index
    @users = UsersFilter.call(users: User.all, params: params)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy

    redirect_to users_path
  end

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def find_tags
    @tags = Tag.all.each_with_object([]) { |tag, arr| arr << [tag.title, tag.id] }
  end

  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :identify_number, tag_ids: [])
  end
end
