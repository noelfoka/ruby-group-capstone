require 'json'
require_relative '../classes/music'
require_relative '../classes/genre'
require_relative 'utils'

module MusicLibrary
  def load_albums_from_json
    if File.exist?('./json_files/albums.json')
      json_content = File.read('./json_files/albums.json')
      return [] if json_content.empty?

      albums_data = JSON.parse(json_content)
      albums_data.map do |data|
        MusicAlbum.new(data['name'], data['publish_date'], data['cover_state'], data['on_spotify'],
                       archived: data['archived'])
      end
    else
      []
    end
  end

  def add_music_album
    @albums = load_albums_from_json
    puts 'Creating a music album... Add details below.'
    name, publish_date, cover_state, on_spotify, archived = collect_album_details
    album = MusicAlbum.new(name, publish_date, cover_state, on_spotify, archived: archived)
    @albums << album

    File.write('./json_files/albums.json', JSON.generate(@albums.map(&:to_hash)))
    puts 'Music album created successfully'
    genre_name = collect_genre_name
    album.genre = find_or_create_genre(genre_name)
    album
  end

  private

  def collect_album_details
    print 'Album Name: '
    name = gets.chomp

    print 'Publish Date: '
    publish_date = gets.chomp

    print 'Cover State (good, bad, etc.): '
    cover_state = gets.chomp

    print 'On Spotify (true/false): '
    on_spotify = gets.chomp.downcase == 'true'

    print 'Archived (true/false): '
    archived = gets.chomp.downcase == 'true'

    [name, publish_date, cover_state, on_spotify, archived]
  end

  def collect_genre_name
    puts 'What genre is the above music album?'
    gets.chomp
  end

  def find_or_create_genre(genre_name)
    existing_genre = @genres.find { |g| g.name == genre_name }
    if existing_genre
      existing_genre
    else
      new_genre = Genre.new(genre_name)
      @genres << new_genre

      File.write('./json_files/genres.json', JSON.generate(@genres.map(&:to_hash)))
      new_genre
    end
  end
end
