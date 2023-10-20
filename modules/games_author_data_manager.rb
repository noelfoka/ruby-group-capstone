require_relative '../classes/game'
require_relative '../classes/author'
require_relative '../classes/item'
require 'json'

def save_game(filename)
  data = @games.map { |game| game.to_hash.merge(title: game.label) }
  save_data(filename, data, 'Game')
end

def save_authors(filename)
  data = @authors.map(&:to_hash)
  save_data(filename, data, 'Author')
end

def load_authors(filename)
  return unless File.exist?(filename)

  data = File.read(filename)
  author_data = JSON.parse(data)
  @authors = author_data.map do |author_data_item|
    author = Author.from_hash(author_data_item)
    author
  end
  puts "Author data loaded from #{filename}"
end

def load_games(filename)
  return unless File.exist?(filename)

  data = File.read(filename)
  game_data = JSON.parse(data)
  @games = game_data.map do |game_data_item|
    game = Game.from_hash(game_data_item)
    game.label = game_data_item['title']
    game
  end
  puts "Game data loaded from #{filename}"
end

def save_data(filename, data, data_type)
  File.write(filename, JSON.pretty_generate(data))
  puts "#{data_type} data saved to #{filename}"
end
