class AlbumsController < ApplicationController
  
  def index
    @albums = Album.all
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
    @album = Album.find(params[:id])
    @album.destroy

    redirect_to @album, notice: 'Deleted successfully'
  end

  private

  def album_params
    params.require(:album).permit(:name,:description)
  end

end
