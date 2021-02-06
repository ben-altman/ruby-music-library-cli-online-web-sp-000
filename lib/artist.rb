require 'pry'

class Artist
  attr_accessor :name
  extend Concerns::Findable
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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
    self.new(name).tap do |artist|  #tap yields self (result of method) to a block, then returns self
      artist.save                   #use "self" rather than class name to allow for abstraction
    end
  end

  def songs
    @songs
  end

  def add_song(song)
    if song.artist == nil
      song.artist = self
    end
    if !@songs.include?(song)
      @songs << song
    end
  end

  def genres
    songs.collect {|song| song.genre}.uniq
  end
end
