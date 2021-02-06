class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(@path).select {|file| file.end_with?(".mp3")}
#      files = Dir.glob("#{path}/*.mp3")
#      files.collect {|f| f.gsub("#{path}/", "")}
  end

  def import
    files.each do |song|
      Song.create_from_filename(song)
    end
  end
end
