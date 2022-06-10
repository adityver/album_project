class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  def index
    @albums = Album.all.page(params[:page])
    @cnt = Album.all
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = current_user.albums.new
  end

  def create
    @album = current_user.albums.new(album_params)

    if @album.save
      redirect_to @album, notice: 'Album was successfully created'
    else
      render :new, alert: 'Album could not be created'
    end
  end

  def edit
    @album = current_user.albums.find(params[:id])
  end

  def update
    @album = current_user.albums.find(params[:id])
    if @album.update(album_params)
      redirect_to @album, notice: 'Updated successfully'
    else
      render :edit, alert: 'Album could not be updated'
    end
  end

  def destroy
    @album = current_user.albums.find(params[:id])
    @album.destroy

    redirect_to @album, notice: 'Deleted successfully'
  end

  def delete_image_attachment
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_back(fallback_location: albums_path)
  end

  def tag_filter
    @album = Album.tagged_with
  end

  private

  def album_params
    params.require(:album).permit(:name,:description,:all_tags,images: [])
  end

end
