class CreaturesController < ApplicationController

  def index
    @creature = Creature.all
    @tag = Tag.all
  end

  def new
    @creature = Creature.new
    @tag = Tag.all
  end

  def create
    @creature = Creature.create(creature_params)
    tags = params[:creature][:tags]
    tags.each do |tag_id|
      @creature.tags << Tag.find_by_id(tag_id) unless tag_id.blank?
    end
    # render :json => params[:creature][:tags]
    redirect_to creatures_path
  end

  def edit
    @creature = Creature.find(params[:id])
    @tag = Tag.all
  end

  def update
    @creature = Creature.update(params[:id], creature_params)

    @creature.tags.clear
    tags = params[:creature][:tag_ids]
    tags.each do |tag_id|
      @creature.tags << Tag.find_by_id(tag_id) unless tag_id.blank?
    end
    redirect_to root_path
  end

  def show

    @creature = Creature.find(params[:id])
    @tag = @creature.tags

    @search = @creature.name

    list = flickr.photos.search :text => @search, :sort => "relevance"

    id     = list[0].id
    secret = list[0].secret
    info = flickr.photos.getInfo :photo_id => id, :secret => secret
    # @photo = info["urls"]["url"][0]["_content"]
    @photo = "http://farm#{info["farm"]}.staticflickr.com/#{info["server"]}/#{info["id"]}_#{info["secret"]}_n.#{info["originalformat"]}"

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