require './Classes/author'
require './Classes/game'
require './Classes/book'
require './Classes/label'
require './Classes/genre'
require './Classes/music'
require './modules/music_logic'
require 'json'
require './modules/load_genres'
require './modules/games_author_data_manager'
require_relative 'modules/user_data_storage'
require_relative 'modules/common_info_data'

class App
  include CommonInfoData
  puts "Welcome to the Catalog Of Things!\n"
  include MusicLibrary

  def initialize
    @data_storage = DataStorage.new
    @data_storage.generate_json_files
    @authors = []
    @games = []
    load_games('json_files/games.json')
    load_authors('json_files/authors.json')
    @genres = load_genres_from_json
    @albums = load_albums_from_json
  end

  def list_genres
    if @genres.empty?
      puts 'There are no genres yet'
    else
      @genres.each do |genre|
        puts "Genre Id: #{genre.id} Name: #{genre.name}"
      end
    end
  end

  def list_music
    if @albums.empty?
      puts 'There are no music albums yet'
    else
      @albums.each do |album|
        puts "Album Name: #{album.name}"
        puts "Publish Date: #{album.publish_date.strftime('%Y-%m-%d')}"
        puts "Cover State: #{album.cover_state}"
        puts "On Spotify: #{album.on_spotify ? 'Yes' : 'No'}"
        puts "Archived: #{album.archived ? 'Yes' : 'No'}"
        puts '---'
      end
    end
  end

  def list_books
    list_items('books.json', '[Book]')
  end

  def list_labels
    list_items('labels.json', '[Label]') do |label, index|
      "#{index + 1}. Title: #{label['title']}, Label Color: #{label['color']}"
    end
  end

  def add_book
    book = create_book
    save_item('books.json', book)
    puts "You've successfully added a new book! 👍"
  end

  # ------- Games and Authors  Methods-------
  def game_details
    puts 'Enter the game details:'
    print 'Title: '
    @title = gets.chomp
    print 'Publish Date (YYYY-MM-DD): '
    @publish_date = gets.chomp
    print 'Multiplayer (yes/no): '
    multiplayer_input = gets.chomp.downcase
    @multiplayer = multiplayer_input == 'yes'
    print 'Last Played Date (YYYY-MM-DD): '
    @last_played_at = gets.chomp
  end

  def authors_details
    print 'Author\'s First Name: '
    @first_name = gets.chomp
    print 'Author\'s Last Name: '
    @last_name = gets.chomp
  end

  def add_game
    game_details
    authors_details
    author = Author.new(@first_name, @last_name)
    game = Game.new(@publish_date, @multiplayer, @last_played_at)
    game.label = @title
    @authors << author
    @games << game
    save_game('json_files/games.json')
    save_authors('json_files/authors.json')
    puts 'Game added successfully.'
    puts 'Author added successfully.'
    puts 'Saved to Json successfully.'
  end

  def list_games
    puts 'List of Games:'
    @games.each_with_index do |game, index|
      puts "
    #{index + 1})Game Title: #{game.label}
     Muntiplayer: #{game.multiplayer}
     Last played: (#{game.publish_date.strftime('%Y-%m-%d')})\n"
    end
  end

  def list_authors
    puts 'List of Authors:'
    @authors.each_with_index do |author, index|
      puts "#{index + 1}) #{author.first_name} #{author.last_name}"
    end
  end

  def run
    prompt
  end

  private

  def create_book
    puts 'Date Published (YY/MM/DD):'
    publish_date = gets.chomp
    publisher = get_user_input("Publisher's name:")
    cover_state = get_user_input('State of book cover (Good or bad):')
    Book.new(publish_date, publisher, cover_state).tap do |book|
      assign_metadata(book)
    end
  end

  def assign_metadata(item)
    label = get_label('json_files/labels.json', item)
    item.label = label
  end

  def save_item(filename, item)
    item_hash = item.to_h.merge({
                                  'label' => item.label
                                })
    @data_storage.save_user_json_data("json_files/#{filename}", item_hash)
  end

  def list_items(filename, item_type)
    items = @data_storage.get_user_json_data("json_files/#{filename}")
    items.each_with_index do |item, index|
      item_details = block_given? ? yield(item, index) : default_item_details(item)
      puts "\n#{item_type} #{item_details}"
    end
    puts "\n\n"
  end

  def default_item_details(item)
    "Label: #{item['label']['title']}"
  end
end
