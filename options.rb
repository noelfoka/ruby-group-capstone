def show_options
  puts "\nPlease choose and option by entering a number:
  1 - List all games
  2 - List all books  📚
  3 - List all music albums 🎶
  4 - List all genres
  5 - List all labels
  6 - List all authors
  7 - Add a book
  8 - Add a music album
  9 - Add a game
  10 - Exit\n"
end

def call_option(option)
  options = {
    1 => method(:list_games),
    2 => method(:list_books),
    3 => method(:list_music),
    4 => method(:list_genres),
    5 => method(:list_labels),
    6 => method(:list_authors),
    7 => method(:add_book),
    8 => method(:add_music_album),
    9 => method(:add_game)
  }

  action = options[option]
  if action
    action.call
  else
    puts 'Choose a number between 1 and 9'
  end
end

def main
  app = App.new
  app.run
end
