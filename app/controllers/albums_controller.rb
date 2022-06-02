class AlbumsController < ApplicationController
  
  def index
    @album = Album.all
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to @album, notice: 'Album was successfully created'
    else
      render :new, notice: 'Album could not be created'
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect to @album, notice: 'Updated successfully'
    else
      render :edit, alert: 'Album could not be updated'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to @article, notice: 'Deleted successfully'
  end

  private

  def album_params
    params.require(:album).permit(:name,:description)
  end
  
end
