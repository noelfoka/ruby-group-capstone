require './Classes/genre'

def load_genres_from_json
  if File.exist?('./json_files/genres.json')
    json_content = File.read('./json_files/genres.json')
    return [] if json_content.empty?

    genres_data = JSON.parse(json_content)
    genres_data.map { |data| Genre.new(data['name']) }
  else
    []
  end
end
