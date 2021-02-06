class Genre
  extend Concerns::Findable

  attr_accessor :name

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
    self.new(name).tap do |song| #tap yields self (result of method) to a block, then returns self
      song.save
    end
  end

  def songs
    @songs
  end

  def artists
    songs.collect {|song| song.artist}.uniq
  end
end
