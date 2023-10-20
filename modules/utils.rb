require 'date'
require 'fileutils'

module Utils
  def input_date
    print 'Year (yyyy): '
    year = gets.chomp.to_i
    print 'Month of the year (mm): '
    month = gets.chomp.to_i
    print 'Day of the month (dd): '
    day = gets.chomp.to_i
    unless Date.valid_date?(year, month, day)
      puts 'Please input a valid date'
      return input_date
    end
    Date.new(year, month, day)
  end

  def check_boolean?(value)
    return true if value == 'y'
    return false if value == 'n'

    puts 'Please enter a valid boolean value (Y/N):'
    value = gets.chomp.downcase
    check_boolean?(value)
  end

  def check_data_folder
    FileUtils.mkdir_p('./data')
  end
end
