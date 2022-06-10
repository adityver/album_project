class TagsController < ApplicationController
  def index
    @tag = Tag.find_by(params[:id])
  end
end

