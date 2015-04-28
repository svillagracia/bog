class CreaturesController < ApplicationController

  def index
    @creature = Creature.all
  end

  def new
    @creature = Creature.new
  end

  def create
    Creature.create(creature_params)
    redirect_to creatures_path
  end

  def show
    @creature = Creature.find(params[:id])
  end

  def destroy
    @creature = Creature.find(params[:id])
    @creature.destroy
    redirect_to creatures_path
  end

  private

  def creature_params
    params.require(:creature).permit(:name,:description)
  end
end