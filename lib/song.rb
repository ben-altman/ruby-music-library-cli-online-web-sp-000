class Song
  attr_accessor :name, :genre
  attr_reader :artist
  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    self.new(name).tap do |song| #tap yields self (result of method) to a block, then returns self
      song.save
    end
  end

  def artist=(artist)
    if @artist == nil
      @artist = artist
    end
    if @artist == artist
      artist.add_song(self)
    end
  end

  def genre=(genre)
    if @genre == nil
      @genre = genre
    end
    if @genre == genre
      genre.songs << self unless genre.songs.include?(self)
    end
  end

  def self.find_by_name(name)
    self.all.detect {|s| s.name == name}
  end

  def self.find_or_create_by_name(name)           #ternary operator "?:"
    self.find_by_name(name) ?
    self.find_by_name(name) :
    self.create(name)
  end

  def self.new_from_filename(filename)
    array = filename.split(" - ")
    name = array[1]
    artist_name = array[0]
    genre_name = array[2].gsub(".mp3", "")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    song = self.new(name, artist, genre)
  end

  def self.create_from_filename(filename)
    @@all << self.new_from_filename(filename)
  end
end
