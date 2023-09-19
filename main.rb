require_relative 'lib/game'
require_relative 'lib/console_interface'
require 'colorize'
require 'colorized_string'

game = Game.new
console_interface = ConsoleInterface.new(game)

until game.finished?
  system "clear"
  puts console_interface.print_results
  user_letter = console_interface.get_letter
  game.check_letter(user_letter)
  break if game.won?
end

puts game.game_result
