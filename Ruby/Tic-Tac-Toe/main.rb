require_relative 'lib/game'
require_relative 'lib/player'

Game.new(HumanPlayer, ComputerPlayer).play
