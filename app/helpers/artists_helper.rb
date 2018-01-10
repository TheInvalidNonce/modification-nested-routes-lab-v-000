module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end
  
  def artist_select(artist, song)
    # If the artist doesn't exist...
    if artist.nil?
      # Create a select_tag, with options for a checkbox selection of Artists.all, by :id, list :name
      select_tag "song[artist_id]", 
      options_from_collection_for_select(Artist.all, :id, :name) 
    else
      # Assign the current song to the new artist being entered by artist_id with a hidden_field_tag
      hidden_field_tag "song[artist_id]", song.artist_id
    end
  end
end
