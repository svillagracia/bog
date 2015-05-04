class TagsController < ApplicationController

  def index
    @tag = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create(tag_params)
    redirect_to tags_path
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.update(params[:id], tag_params)
    redirect_to tags_path
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.creatures.count == 0
    @tag.destroy
    redirect_to tags_path
  end

  def show
    @tag = Tag.find(params[:id])
    @creature = Creature.all
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end