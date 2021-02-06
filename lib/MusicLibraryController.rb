class MusicLibraryController

  def initialize(path=db.mp3s)
    @path = path
    MusicImporter.new(path=db.mp3s)
  end


end
