require_relative 'app'
require_relative 'options'

def prompt
  loop do
    show_options
    option = gets.chomp.to_i
    break if option == 10

    call_option(option)
  end
end
main
