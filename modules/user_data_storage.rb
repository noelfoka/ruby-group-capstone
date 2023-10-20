require 'json'

class DataStorage
  JSON_FILE_PATHS = %w[authors books games genres labels].freeze
  JSON_DATA_DIR = './json_files/'.freeze

  def initialize
    @json_file_paths = JSON_FILE_PATHS.map { |filename| File.join(JSON_DATA_DIR, "#{filename}.json") }
  end

  def generate_json_files
    @json_file_paths.each do |path|
      File.write(path, JSON.generate([])) unless File.exist?(path)
    end
  end

  def get_user_json_data(file)
    json_data = read_json_file(file)
    json_data.is_a?(Array) ? json_data : []
  rescue StandardError
    puts "\nThe file '#{file}' is either not present or empty.\n\n"
    []
  end

  def save_user_json_data(file, data)
    json_data = get_user_json_data(file)

    if data.is_a?(Array)
      json_data.concat(data)
    else
      json_data.push(data)
    end

    write_json_file(file, json_data)
  rescue StandardError
    puts 'Error!'
  end

  private

  def read_json_file(file)
    JSON.parse(File.read(file))
  end

  def write_json_file(file, data)
    File.write(file, JSON.dump(data))
  end
end
