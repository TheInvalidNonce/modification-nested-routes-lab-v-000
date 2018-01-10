class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    # If the Artist params are valid && Artist doesn't exist...
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      # Redirect to Artist index, alert user
      redirect_to artists_path, alert: "Artist not found."
    else
      # Song instance becomes a new song with an assigned artist_id
      @song = Song.new(artist_id: params[:artist_id])
    end
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    # If the artist_id params are valid...
    if params[:artist_id]
      # Find the artist_id, assign the instance to the artist_id
      @artist = Artist.find_by(id: params[:artist_id])
      # If the artist doesn't exist...
      if @artist.nil?
        # Redirect to the artists index, alert the user
        redirect_to artists_path, alert: "Artist not found."
      else
        # Make sure the song belongs to the author, then assign it to the instance
        @song = @artist.songs.find_by(id: params[:id])
        # If the song isn't found, alert the user. Redirect to the artist songs index
        redirect_to artist_songs_path(@artist), alert: "Song not found" if @song.nil?
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end

