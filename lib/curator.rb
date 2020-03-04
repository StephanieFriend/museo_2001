require 'csv'

class Curator

  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def photographs_by_artist
    @photographs.group_by do |photo|
      find_artist_by_id(photo.artist_id)
    end
  end

  def artists_with_multiple_photographs
    artists_and_photos = photographs_by_artist.find_all do |artist, photo|
      photo.length > 1
    end.flatten
    multi_artists = artists_and_photos.map do |multi_artist|
      find_artist_by_id(multi_artist.id)
    end.compact
    multi_artists.map do |artist|
      artist.name
    end.uniq
  end

  def photographs_taken_by_artist_from(country)
    photographs_by_artist.map do |artist, photo|
      if artist.country == country
        photo
      end
    end.flatten.compact
  end

  def load_photographs(file_path)
    # File.open(file_path, "r")
    # CSV.read(file_path, headers: true, header_converters: :symbol)
  end
end