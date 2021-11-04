# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :find_tag, only: %i[destroy update edit]

  def index
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to tags_path(@tag)
    else
      render :new
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path(@tag)
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy

    redirect_to tags_path(@tag)
  end

  def new
    @tag = Tag.new
  end

  private

  def find_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:title)
  end
end
