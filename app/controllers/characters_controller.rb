class CharactersController < ApplicationController
  def index
    respond_to do |format|
      format.json { render :json => Character.all.sort_by(&:name) }
      format.html
    end
  end

  def update
    @character = Character.find params[:id]
    @character.update_attributes params[:character]
    respond_to do |format|
      format.json { render :json => @character }
    end
  end
end
